const assert = require('assert');
const { watermark } = require('./../lib/constants');
const indexer = require('./../lib/indexer');
const { getArgs } = require('./../lib/getargs');

describe('indexer.js', function () {
    describe('#generateIndex()', function () {
        it('should use [quotemark] quotemarks in the result.', function () {
            const testFiles = ['test.ts'];
            const singleResult = indexer.generateIndex(testFiles, `'`);
            const doubleResult = indexer.generateIndex(testFiles, '"');
            const backtickResult = indexer.generateIndex(testFiles, '`');

            assert.strictEqual(singleResult.includes(`'`), true);
            assert.strictEqual(singleResult.includes('"'), false);
            assert.strictEqual(singleResult.includes('`'), false);

            assert.strictEqual(doubleResult.includes(`'`), false);
            assert.strictEqual(doubleResult.includes('"'), true);
            assert.strictEqual(doubleResult.includes('`'), false);

            assert.strictEqual(backtickResult.includes(`'`), false);
            assert.strictEqual(backtickResult.includes('"'), false);
            assert.strictEqual(backtickResult.includes('`'), true);
        });
        it('should use single quotemarks as the default.', function () {
            const testFiles = ['test.ts'];
            const result = indexer.generateIndex(testFiles);
            assert.strictEqual(result.includes(`'`), true);
            assert.strictEqual(result.includes('"'), false);
        });
        it('should include the watermark at the top of the file.', function () {
            const testFiles = ['test.ts'];
            const result = indexer.generateIndex(testFiles);
            assert.deepStrictEqual(
                result.split('\n').slice(0, 2),
                watermark.split('\n').slice(0, 2)
            );
        });
        it('should return null if `fileList` contains no indexable files.', function () {
            let testFiles = ['test.cs', 'testDirectory', 'somefile.js'];
            let result = indexer.generateIndex(testFiles);
            assert.strictEqual(result, null);
        });
    });
    describe('#indexPath()', function () {
        it('should report the correct number of index files generated.', function (done) {
            const args = getArgs(['--path', 'test/test-dirs/control', '--dry-run']);
            const tests = [
                {
                    args: getArgs(['--path', 'test/test-dirs/control', '--dry-run']),
                    expected: { createCount: 1, errorCount: 0, hasIndex: false }
                },
                {
                    args: getArgs(['--path', 'test/test-dirs/nested', '--dry-run']),
                    expected: { createCount: 3, errorCount: 1, hasIndex: false }
                },
                {
                    args: getArgs(['--path', 'test/test-dirs/has-index', '--dry-run']),
                    expected: { createCount: 0, errorCount: 1, hasIndex: true }
                },
                {
                    args: getArgs(['--path', 'test/test-dirs/has-index', '--dry-run', '--overwrite']),
                    expected: { createCount: 1, errorCount: 0, hasIndex: false }
                },
                {
                    args: getArgs(['--path', 'test/test-dirs/nested', '--dry-run', '--exclude', 'first-nest']),
                    expected: { createCount: 2, errorCount: 1, hasIndex: false }
                },
                {
                    args: getArgs(['--path', 'test/test-dirs/nested', '--dry-run', '--exclude', 'second-nest/inner-nest']),
                    expected: { createCount: 3, errorCount: 0, hasIndex: false }
                },
                {
                    args: getArgs(['--path', 'test/test-dirs/nested', '--dry-run', '--exclude', 'second-nest']),
                    expected: { createCount: 2, errorCount: 0, hasIndex: false }
                }
            ];
            Promise.all(tests
                .map((t) => indexer.indexPath(t.args.target, Object.assign({}, t.args, { noLog: true })))
            ).then((results) => {
                for (let i = 0; i < results.length; i++) {
                    try {
                        assert.deepStrictEqual(results[i], tests[i].expected);
                    } catch (error) {
                        done(error);
                        return;
                    }
                }
                done();
            });
        });
    });
});