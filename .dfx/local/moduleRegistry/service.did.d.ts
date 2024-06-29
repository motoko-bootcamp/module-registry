import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export type Result = { 'ok' : null } |
  { 'err' : string };
export type Result_1 = {
    'ok' : {
      'id' : bigint,
      'name' : string,
      'wasm' : Uint8Array | number[],
      'version' : string,
    }
  } |
  { 'err' : string };
export interface moduleRegistry {
  'reboot_registry_getAllModules' : ActorMethod<
    [],
    Array<{ 'id' : bigint, 'name' : string, 'version' : string }>
  >,
  'reboot_registry_getModuleById' : ActorMethod<[bigint], Result_1>,
  'reboot_registry_getModuleByName' : ActorMethod<[string], Result_1>,
  'reboot_registry_registerModule' : ActorMethod<
    [string, string, Uint8Array | number[]],
    Result
  >,
  'reboot_registry_updateModule' : ActorMethod<
    [bigint, string, string, Uint8Array | number[]],
    Result
  >,
}
export interface _SERVICE extends moduleRegistry {}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
