function cosimulate(name, server_address, options)
% COSIMULATE a simulink block with a hdl simulator such as Xcelium.
%   1. Generates a cosim model
%   2. Start simulation server
%      @ xcelium_server_go.sh
%      - Copy the run command files to the server
%      - Copy the hdl files to the server
%      - Starts the server
%   3. Run the cosimulation and compares the simulink with the simulator
%   
%   cosimulate('simulink_model', user@server);
%
%   Insert optional options as a struct. Default values:
%   cosimulate('simulink_model', user@server, struct(...
%       'port', '5908',...
%       'server_files', [root, '/server_files/'],...
%       'tb_extension', _test,...
%       'hdl_file_path', ['hdl_prj/hdlsrc/', name, tb_extension, '/'],...
%       'server_path', '~/Documents/xcelium_cosim/',...
%   ));


    windows_root = erase(fileparts(mfilename('fullpath')),[pwd '\']);
    root = windows_root;
    root(strfind(root,'\'))='/';
    
    if exist('options', 'var') && isfield(options, 'port')
        port = string(options.port);
    else
        port = '5908';
    end
    
    if exist('options', 'var') && isfield(options, 'server_files')
        server_files = options.server_path;
    else
        server_files =  [root, '/server_files/'];
    end
    
    if exist('options', 'var') && isfield(options, 'tb_extension')
        tb_extension = options.tb_extension;
    else
        tb_extension = '_test';
    end

    if exist('options', 'var') && isfield(options, 'file_path')
        hdl_file_path = options.file_path;
    else
        hdl_file_path = ['hdl_prj/hdlsrc/', name, tb_extension, '/'];
    end
    
    if exist('options', 'var') && isfield(options, 'server_path')
        server_path = options.server_path;
    else
        server_path = '~/Documents/xcelium_cosim/';
    end

    open([name, '_test']);
    makehdltb([name, tb_extension,'/' , name], 'GenerateCoSimModel', 'Incisive');
    set_param(['gm_' name tb_extension '_in/' name '_in'], 'CommLocal', 0);
    set_param(['gm_' name tb_extension '_in/' name '_in'], 'CommHostName', extractAfter(server_address, "@"));
    set_param(['gm_' name tb_extension '_in/' name '_in'], 'CommPortNumber', port);
    set_param(['gm_' name tb_extension '_in/' name '_in'], 'TclPostSimCommand', 'after 1 {exit}');
    
    cmd = ['start ' windows_root '\xcelium_server_go.sh ' name ' "' server_files '*" "' hdl_file_path '*.vhd" ' server_address ' ' server_path ' ' port];
    system(cmd);
    loop_try_sim(5);

    function loop_try_sim(max_loops)
        try
            out = sim(['gm_' name '_test_in']);
        catch error
           if strcmp(error.identifier, 'Simulink:SFunctions:SFcnErrorStatus')
               loop_try_sim(max_loops-1);
           else
               rethrow(error)
           end
        end
    end
end

