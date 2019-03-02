function [value_new] = Reorder(value)
%Reorder This function reorder 1*X array to (X/3)*3 array.
%   To do scatter plot, 1*X array has to be reordered. Import PTV or OAR
%   and reorder it.
len = size(value,2);
len_row = len/3;
value_new = zeros(len_row,3);
col=0;
row=0;
for num = 1:len
    if rem(num,len_row)==1
        col = col+1;
        row = 0;
    end
    row = row + 1;
    value_new(row,col) = value(1,num);
end
end

