function Name = groupName()

promptGroup = {'Insert name of control/sample group.'};
dlgtitleGroup = 'Group naming';
dimsGroup = [1 35];
definputGroup = {'Control'};
answer2D = inputdlg(promptGroup,dlgtitleGroup,dimsGroup,definputGroup);
Name = answer2D;


end


