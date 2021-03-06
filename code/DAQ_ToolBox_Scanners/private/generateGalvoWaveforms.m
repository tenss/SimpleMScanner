function dataToPlay = generateGalvoWaveforms(imSize,scanAmplitude,samplesPerPixel,fillFraction,scanPattern,verbose)
% Produce galvo wavorms for 2-photon microscope scanning 
%
% function dataToPlay = generateGalvoWaveforms(imSize,scanAmplitude,samplesPerPixel,fillFraction,scanPattern,verbose)
%
% Purpose
% Generates the galvo waveforms for a 2-photon microscope. Patterns for square images only are produced.
%
% 
% Inputs
% imSize - Scalar defining the number of rows and columns in the image. 
%          e.g. if imSize is 256, then a 256 by 256 image is produced
% scanAmplitude - Scalar defining the maximum (+/-) voltage of the waveform. 
%          e.g. if scanAmplitude is 2 then data are acquired using waveform 
%           command voltages going between +/- 2 (but see "fillFraction")
% samplesPerPixel - Scalar defining the number of samples contributing to each pixel. Increasing
%           this value will increase image quality but decrease frame rate.
% fillFraction - Scalar (0 to 1) defining what proportion of the waveform to keep and 
%           use for image formation. This is used to remove the x mirror turn-around 
%           artefacts. e.g. if fillfraction is 0.9, we will remove the outer 10% of the waveform. 
%           In order to maintain a square image, we increase the size of the scanned area to compensate.
% scanPattern - 'bidi' or 'uni' (uni by default)
% verbose     - false by default. If true, print diagnostic messages to screen. 
%
%
% Outputs
% dataToPlay - an N-by-2 array of values corresponding to the galvo waveforms for one frame.
%              First column is X waveform and second is Y waveform.
%
%
% Rob Campbell - Basel 2016
    
    %Check the input arguments
    if ~isscalar(imSize)
        error('imSize should be a scalar\n')
    end
    if ~isscalar(scanAmplitude)
        error('scanAmplitude should be a scalar\n')
    end
    if ~isscalar(samplesPerPixel)
        error('samplesPerPixel should be a scalar\n')
    end
    if ~isscalar(fillFraction)
        error('fillFraction should be a scalar\n')
    end
    if nargin<5
        scanPattern='uni';
    end
    if ~ischar(scanPattern)
        error('scanPattern should be a string')
    end
    if ~strcmpi(scanPattern,'uni') && ~strcmpi(scanPattern,'bidi')
        error('scanPattern must be the string "uni" or "bidi"')
    end
    if nargin<6
        verbose=false;
    end

    %Ensure scan amplitude isn't too large (scanners take +/- 10V)
    scanAmplitude = abs(scanAmplitude);
    if scanAmplitude>10
        error('scanAmplitude should be less than 10')
    end

    % Calculate the number of samples per line. We want to produce a final image composed of
    % imSize data points on each line. However, if the fill fraction is less than 1, we
    % need to collect more than this then trim it back when we build the image. 
    % The number of samples collected per line will scale with the number of samples per point
    fillFractionExcess = 2-fillFraction; %The proprotional increase in scanned area along X
    pixelsPerLine=ceil(imSize*fillFractionExcess);
    samplesPerLine = pixelsPerLine*samplesPerPixel;

    if verbose
        if fillFraction<1
            fprintf('Based on a fill-fraction of %0.1f, the number of pixels per line goes up from %d to %d\n',...
                fillFraction, imSize,pixelsPerLine)
        else
            fprintf('There are %d pixels per line\n',imSize)
        end
    end

    %Produce the Y waveform and retain a square image
    yScanAmp = scanAmplitude*fillFraction; %zoom in with Y to compensate for the region lost in X due to the fill fraction changing
    yWaveform = linspace(yScanAmp, -yScanAmp, samplesPerLine*imSize);


    %Produce the X waveform
    xWaveform = linspace(-scanAmplitude, scanAmplitude, samplesPerLine);

    if strcmpi(scanPattern,'bidi')
        if verbose
            fprintf('Building bidirectional scan waveform\n')
        end
        xWaveform = [xWaveform,fliplr(xWaveform)];
    end

    xWaveform = repmat(xWaveform,1,ceil(length(yWaveform)/length(xWaveform)));
    
    if length(xWaveform) < length(yWaveform)
        error('xWaveform is shorter than yWaveform. The x is %d long and the y %d long',...
            length(xWaveform), length(yWaveform));
    end
    xWaveform = xWaveform(1:length(yWaveform));
    
    if verbose
        fprintf('Final waveforms have a length of %d\n',length(xWaveform))
    end

    %Assemble the two waveforms into an N-by-2 array that can be sent to the NI board
    dataToPlay = [xWaveform(:),yWaveform(:)];



