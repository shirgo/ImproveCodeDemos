
function testFitRedo1(desiredTest,splineSample)
%% Example 1
% Input values desiredTest = 60, splineSample = 200;
%
% Load in output of a desired model, fit, filter and evaluate a spline
% Output written into an excel data file

%% Finding Names of all Text Files in the ModelResults Directory

filexlsName = 'FinalResults.xls';
dirName = fullfile(pwd, 'ModelResults');
modelFiles = dir(fullfile(dirName, ['*.', 'txt']));

% Preallocation
xlsData = cell(1,length(modelFiles));

disp('Processing test results...');

%% Reading, Averaging, and Fitting all Text Files
for i = 1:length(modelFiles)
    
    %% Read in the Relevant Model Data
    fileName = fullfile(dirName, modelFiles(i).name);
    [~, modelName] = fileparts(modelFiles(i).name);
    fid = fopen(fileName);
    
    % Getting the number of timesteps from the header of the txt file
    nTimes = textscan(fid,'%*s %s \n',1);
    nTimes = str2double(nTimes{1});
    
    % Read through models we don't want data from and keep resaving model
    % info into modelData until it gets to desiredModel
    for j=1:desiredTest-1
        fgets(fid);
        textscan(fid, '%*f %*f \n',nTimes); % get model output data
    end
    
    fgets(fid);
    modelData = textscan(fid, '%f %f \n',nTimes); % get model output data
    modelData = cell2mat(modelData);
    
    fclose(fid);
    
    %% Filter, Fit and Evaluate Spline on Model Data
    
    nPoints = 10;  % setting number of points to average over
    b = (1/nPoints)*ones(1,nPoints);  % moving average over nPoints
    filterData = filter(b,1,modelData); % create moving average
    
    splineData = spline(filterData(:,1),filterData(:,2)); % create spline
    splineTime = linspace(0,filterData(end,1),splineSample);
    finalData = ppval(splineData,splineTime); % evaluate spline
    
    xlsData{1,i} = [splineTime',finalData'];
    
    %% Plot the Results
    
    figure;
    
    subplot(2,1,1)
    plot(modelData(:,1),modelData(:,2));
    hold on
    plot(filterData(:,1),filterData(:,2),'r');
    title('Original and Moving Average')
    hold off
    
    subplot(2,1,2)
    plot(filterData(:,1),filterData(:,2));
    hold on
    plot(splineTime,finalData,'r+');
    title('Moving Average and Spline')
    hold off
    
    saveas(gcf, fullfile('PlotFigs', [modelName, '.fig']));
    
end

close all % close all figures

%% Output Spline Results to an Excel File

xlswrite(filexlsName,cell2mat(xlsData));

