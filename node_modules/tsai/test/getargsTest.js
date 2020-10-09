const assert = require('assert');
const { getArgs, SLASH_REGEX } = require('./../lib/getargs');
const path = require('path');

const TEST_PATHS = [
    'simple-path',
    'my/nested/path',
    'my\\windows\\path',
    'really\\unusual/path',
    'simple with spaces',
    'nested with/spaces',
    'windows\\nested with\\spaces',
    'unusual\\path with/spaces',
    '../relative/../path'
];

describe('getargs.js', function () {
    describe('#getArgs()', function () {
        it('should return the default result for no arguments.', function () {
            let args = getArgs([]);
            assert.strictEqual(args.quotemark, `'`);
            assert.strictEqual(args.overwrite, false);
            assert.strictEqual(args.target, process.cwd());
            assert.deepStrictEqual(args.exclude, ['node_modules']);
            assert.strictEqual(args.dryrun, false);

            args = getArgs(null);
            assert.strictEqual(args.quotemark, `'`);
            assert.strictEqual(args.overwrite, false);
            assert.strictEqual(args.target, process.cwd());
            assert.deepStrictEqual(args.exclude, ['node_modules']);
            assert.strictEqual(args.dryrun, false);
        });
        it('should enable dry run if the --dry-run flag is provided', function () {
            let args = getArgs(['--dry-run']);
            assert.strictEqual(args.dryrun, true);
        });
        it('should throw an error if the path flag is included without a path', function () {
            assert.throws(getArgs.bind(getArgs, ['--path']));
            assert.throws(getArgs.bind(getArgs, ['-p']));
            assert.doesNotThrow(getArgs.bind(getArgs, ['--path', 'mypath']));
            assert.doesNotThrow(getArgs.bind(getArgs, ['-p', 'path']));
        });
        it('should use double quotemarks if the --double flag is provided', function () {
            let args = getArgs(['--double']);
            assert.strictEqual(args.quotemark, '"');
            args = getArgs(['-d']);
            assert.strictEqual(args.quotemark, '"');
        });
        it('should set overwrite to true if the --overwrite flag is provided', function () {
            let args = getArgs(['--overwrite']);
            assert.strictEqual(args.overwrite, true);
            args = getArgs(['-o']);
            assert.strictEqual(args.overwrite, true);
        });
        it('should use the provided --path in the target', function () {
            for (const test of TEST_PATHS) {
                let args = getArgs(['--path', test]);
                assert.strictEqual(args.target, path.join(process.cwd(), ...test.split(SLASH_REGEX)));
            }
        });
        it('should throw an error if no paths are provided for --exclude', function () {
            assert.throws(getArgs.bind(getArgs, ['--exclude']));
            assert.throws(getArgs.bind(getArgs, ['-e']));
            assert.throws(getArgs.bind(getArgs, ['--exclude', '--path']));
            assert.throws(getArgs.bind(getArgs, ['--e', '--path']));
            assert.doesNotThrow(getArgs.bind(getArgs, ['--exclude', 'mypath']));
            assert.doesNotThrow(getArgs.bind(getArgs, ['-e', 'mypath']));
        });
        it('should always exclude node_modules', function () {
            let args = getArgs([]);
            assert.notEqual(args.exclude.indexOf('node_modules'), -1);
            args = getArgs(['--exclude', 'path/one', 'path/two']);
            assert.notEqual(args.exclude.indexOf('node_modules'), -1);
            args = getArgs(['-e', 'windows\\path']);
            assert.notEqual(args.exclude.indexOf('node_modules'), -1);
        });
        it('should add any paths provided after --exclude', function () {
            for (const test of TEST_PATHS) {
                let args = getArgs(['--exclude', test]);
                assert.deepStrictEqual(['node_modules', path.join(...test.split(SLASH_REGEX))], args.exclude);
            }
            for (let i = 0; i < TEST_PATHS - 1; i++) {
                let args = getArgs(['-e', ...TEST_PATHS.slice(i, i + 2)]);
                assert.deepStrictEqual(['node_modules', ...TEST_PATHS.slice(i, i + 2)
                    .map((p) => path.join(...p.split(SLASH_REGEX)))], args.exclude);
            }
        });
    });
});