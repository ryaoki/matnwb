function checkUnset(obj, argin)
props = properties(obj);
%anonNames = {};  
anonNames = {'description'}; % changed @ 210607 by RA 
for i = 1:length(props)
    p = obj.(props{i});
    if isa(p, 'types.untyped.Anon')
        anonNames = [anonNames;{p.name}];
    elseif isa(p, 'types.untyped.Set')
        anonNames = [anonNames;keys(p) .'];
    end
end
dropped = setdiff(argin, [props;anonNames]);
assert(isempty(dropped),...
    'NWB:CheckUnset:InvalidProperties',...
    ['Unexpected properties {%s}.  '...
        '\n\nYour schema version may be incompatible with the file.  '...
        'Consider checking the schema version of the file with '...
        '`util.getSchemaVersion(filename)` '...
        'and comparing with the YAML namespace version present in '...
        'nwb-schema/core/nwb.namespace.yaml'], misc.cellPrettyPrint(dropped));
end