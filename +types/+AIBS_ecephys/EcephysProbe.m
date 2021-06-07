classdef EcephysProbe < types.core.ElectrodeGroup & types.untyped.GroupClass
% ECEPHYSPROBE A group consisting of the channels on a single neuropixels probe.


% READONLY
properties(SetAccess=protected)
    help; % Value is 'Metadata about a physical grouping of channels'
end
% PROPERTIES
properties
    has_lfp_data; % indicates availability of lfp data
    lfp_sampling_rate; % the (probably reduced) sampling rate at which lfp data were acquired on this probe's channels
    sampling_rate; % the sampling rate at which data were acquired on this probe's channels
end

methods
    function obj = EcephysProbe(varargin)
        % ECEPHYSPROBE Constructor for EcephysProbe
        %     obj = ECEPHYSPROBE(parentname1,parentvalue1,..,parentvalueN,parentargN,name1,value1,...,nameN,valueN)
        % has_lfp_data = logical
        % help = char
        % lfp_sampling_rate = float64
        % sampling_rate = float64
        varargin = [{'help' 'A physical grouping of channels'} varargin];
        obj = obj@types.core.ElectrodeGroup(varargin{:});
        
        
        p = inputParser;
        p.KeepUnmatched = true;
        p.PartialMatching = false;
        p.StructExpand = false;
        addParameter(p, 'has_lfp_data',[]);
        addParameter(p, 'help',[]);
        addParameter(p, 'lfp_sampling_rate',[]);
        addParameter(p, 'sampling_rate',[]);
        misc.parseSkipInvalidName(p, varargin);
        obj.has_lfp_data = p.Results.has_lfp_data;
        obj.help = p.Results.help;
        obj.lfp_sampling_rate = p.Results.lfp_sampling_rate;
        obj.sampling_rate = p.Results.sampling_rate;
        if strcmp(class(obj), 'types.AIBS_ecephys.EcephysProbe')
            types.util.checkUnset(obj, unique(varargin(1:2:end)));
        end
    end
    %% SETTERS
    function obj = set.has_lfp_data(obj, val)
        obj.has_lfp_data = obj.validate_has_lfp_data(val);
    end
    function obj = set.lfp_sampling_rate(obj, val)
        obj.lfp_sampling_rate = obj.validate_lfp_sampling_rate(val);
    end
    function obj = set.sampling_rate(obj, val)
        obj.sampling_rate = obj.validate_sampling_rate(val);
    end
    %% VALIDATORS
    
    function val = validate_description(obj, val)
        val = types.util.checkDtype('description', 'char', val);
    end
    function val = validate_device(obj, val)
        val = types.util.checkDtype('device', 'types.core.Device', val);
    end
    function val = validate_has_lfp_data(obj, val)
        val = types.util.checkDtype('has_lfp_data', 'logical', val);
    end
    function val = validate_lfp_sampling_rate(obj, val)
        val = types.util.checkDtype('lfp_sampling_rate', 'float64', val);
    end
    function val = validate_location(obj, val)
        val = types.util.checkDtype('location', 'char', val);
    end
    function val = validate_sampling_rate(obj, val)
        val = types.util.checkDtype('sampling_rate', 'float64', val);
    end
    %% EXPORT
    function refs = export(obj, fid, fullpath, refs)
        refs = export@types.core.ElectrodeGroup(obj, fid, fullpath, refs);
        if any(strcmp(refs, fullpath))
            return;
        end
        if ~isempty(obj.has_lfp_data)
            io.writeAttribute(fid, [fullpath '/has_lfp_data'], obj.has_lfp_data);
        else
            error('Property `has_lfp_data` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.help)
            io.writeAttribute(fid, [fullpath '/help'], obj.help);
        else
            error('Property `help` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.lfp_sampling_rate)
            io.writeAttribute(fid, [fullpath '/lfp_sampling_rate'], obj.lfp_sampling_rate);
        else
            error('Property `lfp_sampling_rate` is required in `%s`.', fullpath);
        end
        if ~isempty(obj.sampling_rate)
            io.writeAttribute(fid, [fullpath '/sampling_rate'], obj.sampling_rate);
        else
            error('Property `sampling_rate` is required in `%s`.', fullpath);
        end
    end
end

end