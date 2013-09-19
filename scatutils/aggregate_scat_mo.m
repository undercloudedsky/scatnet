
% aggregate_scat: Aggregate successive frames of a scattering transform.
% Usage
%    S = aggregage_scat(S,N)
% Input
%    S: A scattering transform.
%    N: The length of the window with which to aggregate.
% Output
%    S: The scattering transform with successive frames within a window of
%       length N aggregated into one frame, multiplying the number of paths.

function Y = aggregate_scat_mo(X,N)
for m = 0:length(X)-1
    Y{m+1}.signal = {};
    % initialize target meta with same fields as source
    Y{m+1}.meta = struct();
    field_names = fieldnames(X{m+1}.meta);
    for k = 1:length(field_names)
        Y{m+1}.meta = setfield(Y{m+1}.meta,field_names{k}, ...
            zeros(size(getfield(X{m+1}.meta,field_names{k}),1),0));
    end
    r1 = 1;
    for p1 = 1:length(X{m+1}.signal)
        signal = X{m+1}.signal{p1};
        % determine the window size at the current resolution
        N1 = N/2^(X{m+1}.meta.resolution(p1));
        % copy metas of this signal into metas of multiple signals
        
        Y{m+1}.meta = map_meta(X{m+1}.meta,p1,Y{m+1}.meta,r1:r1+N1-1);
        % extract set of frames of length N1
        %s=size(signal,3);
        
        if size(signal,3)>1
            signal2=zeros(N1,size(signal,1)/N1,size(signal,2),size(signal,3));
            for d3=1:size(signal,3)
                signal2(:,:,:,d3) = reshape(signal(:,:,d3),[N1 size(signal,1)/N1 size(signal,2)]);  
            end
            %size(signal2)
            signal2 = permute(signal2,[2 3 1 4]);
            %size(signal2)
            for k1=1:N1
                sig=zeros(size(signal2,1),size(signal2,2),size(signal2,4));
                for l=1:size(signal2,4)
                    sig(:,:,l)=signal2(:,:,k1,l);
                end
                %sig=permute(sig,[1 3 2]);
                Y{m+1}.signal{r1} = sig;
                r1 = r1+1;
            end
            
        else signal = reshape(signal,[N1 size(signal,1)/N1 size(signal,2)]);
            
            signal = permute(signal,[2 3 1]);
            
            for k1 = 1:N1
                Y{m+1}.signal{r1} = signal(:,:,k1);
                r1 = r1+1;
            end
        end
    end
end

end