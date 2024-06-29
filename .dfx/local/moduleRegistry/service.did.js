export const idlFactory = ({ IDL }) => {
  const Result_1 = IDL.Variant({
    'ok' : IDL.Record({
      'id' : IDL.Nat,
      'name' : IDL.Text,
      'wasm' : IDL.Vec(IDL.Nat8),
      'version' : IDL.Text,
    }),
    'err' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const moduleRegistry = IDL.Service({
    'reboot_registry_getAllModules' : IDL.Func(
        [],
        [
          IDL.Vec(
            IDL.Record({
              'id' : IDL.Nat,
              'name' : IDL.Text,
              'version' : IDL.Text,
            })
          ),
        ],
        ['query'],
      ),
    'reboot_registry_getModuleById' : IDL.Func([IDL.Nat], [Result_1], []),
    'reboot_registry_getModuleByName' : IDL.Func([IDL.Text], [Result_1], []),
    'reboot_registry_registerModule' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Vec(IDL.Nat8)],
        [Result],
        [],
      ),
    'reboot_registry_updateModule' : IDL.Func(
        [IDL.Nat, IDL.Text, IDL.Text, IDL.Vec(IDL.Nat8)],
        [Result],
        [],
      ),
  });
  return moduleRegistry;
};
export const init = ({ IDL }) => { return []; };
