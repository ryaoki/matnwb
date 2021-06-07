classdef EcephysLabMetaData < types.core.LabMetaData & types.untyped.GroupClass
% ECEPHYSLABMETADATA metadata for ecephys sessions


% PROPERTIES
properties
    age_in_days; % age of this subject, in days
    full_genotype; % long-form description of this subjects genotype
    sex; % this subjects sex
    specimen_name; % full name of this specimen
    stimulus_name; % the name of the stimulus set used for this session
    strain; % this subjects strain
end

methods
    function obj = EcephysLabMetaData(varargin)
        % ECEPHYSLABMETADATA Constructor for EcephysLabMetaData
        %     obj = ECEPHYSLABMETADATA(parentname1,parentvalue1,..,parentvalueN,parentargN,name1,value1,...,nameN,valueN)
        % age_in_days = float
        % full_genotype = char
        % sex = char
        % specimen_name = char
        % stimulus_name = char
        % strain = char
        obj = obj@types.core.LabMetaData(varargin{:});
        
        
        p = inputParser;
        p.KeepUnmatched = true;
        p.PartialMatching = false;
        p.StructExpand = false;
        addParameter(p, 'age_in_days',[]);
        addParameter(p, 'full_genotype',[]);
        addParameter(p, 'sex',[]);
        addParameter(p, 'specimen_name',[]);
        addParameter(p, 'stimulus_name',[]);
        addParameter(p, 'strain',[]);
        misc.parseSkipInvalidName(p, varargin);
        obj.age_in_days = p.Results.age_in_days;
        obj.full_genotype = p.Results.full_genotype;
        obj.sex = p.Results.sex;
        obj.specimen_name = p.Results.specimen_name;
        obj.stimulus_name = p.Results.stimulus_name;
        obj.strain = p.Results.strain;
        if strcmp(class(obj), 'types.AIBS_ecephys.EcephysLabMetaData')
            types.util.checkUnset(obj, unique(varargin(1:2:end)));
        end
    end
    %% SETTERS
    function obj = set.age_in_days(obj, val)
        obj.age_in_days = obj.validate_age_in_days(val);
    end
    function obj = set.full_genotype(obj, val)
        obj.full_genotype = obj.validate_full_genotype(val);
    end
    function obj = set.sex(obj, val)
        obj.sex = obj.validate_sex(val);
    end
    function obj = set.specimen_name(obj, val)
        obj.specimen_name = obj.validate_specimen_name(val);
    end
    function obj = set.stimulus_name(obj, val)
        obj.stimulus_name = obj.validate_stimulus_name(val);
    end
    function obj = set.strain(obj, val)
        obj.strain = obj.validate_strain(val);
    end
    %% VALIDATORS
    
    function val = validate_age_in_days(obj, val)
        val = types.util.checkDtype('age_in_days', 'float', val);
    end
    function val = validate_full_genotype(obj, val)
        val = types.util.checkDtype('full_genotype', 'char', val);
    end
    function val = validate_sex(obj, val)
        val = types.util.checkDtype('sex', 'char', val);
    end
    function val = validate_specimen_name(obj, val)
        val = types.util.checkDtype('specimen_name', 'char', val);
    end
    function val = validate_stimulus_name(obj, val)
        val = types.util.checkDtype('stimulus_name', 'char', val);
    end
    function val = validate_strain(obj, val)
        val = types.util.checkDtype('strain', 'char', val);
    end
    %% EXPORT
    function refs = export(obj, fid, fullpath, refs)
        refs = export@types.core.LabMetaData(obj, fid, fullpath, refs);
        if any(strcmp(refs, fullpath))
            return;
        end
        if ~isempty(obj.age_in_days)
            io.writeAttribute(fid, [fullpath '/age_in_days'], obj.age_in_days);
        else
            error('Property `age_in_days` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.full_genotype)
            io.writeAttribute(fid, [fullpath '/full_genotype'], obj.full_genotype);
        else
            error('Property `full_genotype` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.sex)
            io.writeAttribute(fid, [fullpath '/sex'], obj.sex);
        else
            error('Property `sex` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.specimen_name)
            io.writeAttribute(fid, [fullpath '/specimen_name'], obj.specimen_name);
        else
            error('Property `specimen_name` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.stimulus_name)
            io.writeAttribute(fid, [fullpath '/stimulus_name'], obj.stimulus_name);
        else
            error('Property `stimulus_name` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.strain)
            io.writeAttribute(fid, [fullpath '/strain'], obj.strain);
        else
            error('Property `strain` is required in `%s`.', fullpath);
        end
    end
end

end