function S = getScannerObjectFromBaseWorkSpace(className,verbose)
% Returns the scanAndAcquire object from the base workspace regardless of its name
%
% function S = getScannerObjectFromBaseWorkSpace(className,verbose)
%
% Purpose
% Used by methods or objects that want to import scanAndAcquire_OO without 
% requiring it to be passed as an input argument.
%
% Inputs (optional)
% className - a string defining the name of the class to search for. If missig
% 			 of empty we search for the string 'scanAndAcquire_OO'
% verbose - optional bool (true by default). If true print status of object 
%			search to screen.
%
% Outputs
% S - the scanAndAcquire_OO object. Returns empty if it could not be found. 
%
%
% Rob Campbell - Basel 2016

if nargin<1  || isempty(className)
	className='scanAndAcquire_OO';
end

if nargin<2 || isempty(verbose)
	verbose=true;
end

W=evalin('base','whos');

varClasses = {W.class};




ind=strmatch(className,varClasses);


if isempty(ind)
	%Return empty if no object was found
	if verbose
		fprintf('No %s object in base workspace\n',className)
	end
	S=[];
	return
end


if length(ind)>1
	%Return empty if multiple objects were found
	if verbose
		fprintf('More than one %s object in base workspace\n',className)
	end
	S=[];
	return
end


S=evalin('base',W(ind).name);


if ~isvalid(S)
	%Return empty if object is not valid (although isvalid is for timer objects it seems to work here too)
	if verbose
		fprintf('No valid %s object in base workspace\n',className)
	end
	S=[];
	return
end
