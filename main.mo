import Text "mo:base/Text";
import Result "mo:base/Result";
import Buffer "mo:base/Buffer";

shared ({ caller = creator }) actor class moduleRegistry() = this {

    public type Result<Ok, Err> = Result.Result<Ok, Err>;

    //TODO: Arrays should be replaced by a more efficient data structure soon.
    stable var modules : [(Nat, Text, Text, Blob)] = []; // [(canisterId, name, version, wasm)]

    stable var id : Nat = 0;

    //TODO: Implements a list of callers and its installed modules, status for tracking, updating modules, etc.

    public shared func reboot_registry_registerModule(name : Text, version : Text, wasm : Blob) : async Result<(), Text> {

        let moduleBuff : Buffer.Buffer<(Nat, Text, Text, Blob)> = Buffer.fromArray(modules);

        if (Buffer.contains(moduleBuff, (id, name, version, wasm), func (x : (Nat, Text, Text, Blob), y : (Nat, Text, Text, Blob)) : Bool { x.0 == y.0 })) {
            return #err("Already exists");
        };

        moduleBuff.add((id, name, version, wasm));
        modules := Buffer.toArray(moduleBuff);
        id += 1;

        return #ok();
    };

    public shared func reboot_registry_getModule(name : Text, version : Text) : async Result<{ id : Nat; name : Text; version : Text; wasm : Blob }, Text> {

        let moduleBuff : Buffer.Buffer<(Nat, Text, Text, Blob)> = Buffer.fromArray(modules);

        for (mod in moduleBuff.vals()) {
            if (mod.1 == name and mod.2 == version) {
                return #ok({
                    id = mod.0;
                    name = mod.1;
                    version = mod.2;
                    wasm = mod.3;
                });
            };
        };

        return #err("Module not found");
    };

    public shared func reboot_registry_getModuleByName(name : Text) : async Result<{ id : Nat; name : Text; version : Text; wasm : Blob }, Text> {

        let moduleBuff : Buffer.Buffer<(Nat, Text, Text, Blob)> = Buffer.fromArray(modules);

        for (mod in moduleBuff.vals()) {
            if (mod.1 == name) {
                return #ok({
                    id = mod.0;
                    name = mod.1;
                    version = mod.2;
                    wasm = mod.3;
                });
            };
        };

        return #err("Module not found");
    };

    public shared func reboot_registry_getModuleById(identifier : Nat) : async Result<{ id : Nat; name : Text; version : Text; wasm : Blob }, Text> {

        let moduleBuff : Buffer.Buffer<(Nat, Text, Text, Blob)> = Buffer.fromArray(modules);

        for (mod in moduleBuff.vals()) {
            if (mod.0 == identifier) {
                return #ok({
                    id = mod.0;
                    name = mod.1;
                    version = mod.2;
                    wasm = mod.3;
                });
            };
        };

        return #err("Module not found");
    };

    public query func reboot_registry_getAllModules() : async [{ id : Nat; name : Text; version : Text}] {

        let moduleBuff : Buffer.Buffer<(Nat, Text, Text, Blob)> = Buffer.fromArray(modules);

        return Buffer.toArray(
            Buffer.map<(Nat, Text, Text, Blob), { id : Nat; name : Text; version : Text}>(
                moduleBuff : Buffer.Buffer<(Nat, Text, Text, Blob)>, 
                func (x : (Nat, Text, Text, Blob)) : { id : Nat; name : Text; version : Text} { { id = x.0; name = x.1; version = x.2 } }
            ));

    };

};
