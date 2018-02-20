function indToUpdate = getMappedInd(minNode, neighSize)

W_ref = reshape(1:100,10,10);
x = ceil(minNode/10);
y = mod(minNode,10);
switch neighSize
    case 0
        indToUpdate = minNode;
    case 1
        %x = ceil(minNode/10);
        %y = mod(minNode,10);
        indToUpdate = zeros(1,9);
        indicate = [-1 0 1];
        k = 0;
        for i = 1:length(indicate)
            for j = 1:length(indicate)
                k = k+1;
                try
                    yref = y+indicate(j);
                    xref = x+indicate(i);
                    indToUpdate(k) = W_ref(yref,xref);
                catch
                    indToUpdate(k) = nan;
                end
            end
        end
            
        indToUpdate = indToUpdate(~isnan(indToUpdate));

%         if minNode > 10 && minNode < 91
%             modMinNode = mod(minNode,10);
%             if modMinNode > 1
%                 indToUpdate = [minNode-11:minNode+9,...
%                                 minNode-1:minNode+1,...
%                                 minNode+9:minNode+11];
%             elseif modMinNode == 1
%                 indToUpdate = [minNode-10, minNode-9, minNode,...
%                                 minNode+1, minNode+10, minNode+11];
%             elseif modMinNode == 0
%                 indToUpdate = [minNode-11, minNode-10, minNode-1,...
%                                 minNode, minNode+10, minNode+11];
%             end
%         elseif minNode <= 10
%             if minNode > 1 && minNode
%         end
    case 2
        indToUpdate = zeros(1,25);
        indicate = [-2 -1 0 1 2];
        k = 0;
        for i = 1:length(indicate)
            for j = 1:length(indicate)
                k = k+1;
                try
                    yref = y+indicate(j);
                    xref = x+indicate(i);
                    indToUpdate(k) = W_ref(yref,xref);
                catch
                    indToUpdate(k) = nan;
                end
            end
        end
            
        indToUpdate = indToUpdate(~isnan(indToUpdate));
end