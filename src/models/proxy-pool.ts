import { Proxy } from './proxy';

export interface ProxyPool {
    enabled: boolean,
    cooldown: number,
    fails: number,
    proxy: Proxy;
}