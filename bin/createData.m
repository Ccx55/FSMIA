function result = createData(type,varargin)
global Option;
switch type
    case 'Trajectory'
        if isfield(Option,'IgnoreFirstLastFrame') && Option.IgnoreFirstLastFrame
            result = GenerateTrajectory_v1;
        else
            result = GenerateTrajectory_v2;
        end
    otherwise
        disp('Type not supported!')
        result = [];
end

function traj = GenerateTrajectory_v1
global Molecule;
global Frame;
traj = struct([]);
NumMoleculeFirstFrame = length(Frame(1).MoleculeIndex);
NumMoleculeLastFrame = length(Frame(end).MoleculeIndex);
N_frame = length(Frame);
N1 = NumMoleculeFirstFrame+1;
N2 = length(Molecule) - NumMoleculeLastFrame;
k = 1;
for i = N1:N2
    if isempty(Molecule(i).From) && ~isempty(Molecule(i).To)
        temp = zeros(1,N_frame);
        temp(1) = i;
        current = i;
        j = 2;
        while ~isempty(Molecule(current).To)
            temp(j) = Molecule(current).To;
            current = Molecule(current).To;
            j = j+1;
        end
        path = temp(find(temp));
        if Molecule(path(end)).frame<N_frame
            traj(k).trajectory = path;
            k = k+1;
        end
    end
end


function traj = GenerateTrajectory_v2
global Molecule;
global Frame;
traj = struct([]);

NumMoleculeLastFrame = length(Frame(end).MoleculeIndex);
N_frame = length(Frame);

N2 = length(Molecule) - NumMoleculeLastFrame;
k = 1;
for i = 1:N2
    if ~isempty(Molecule(i).To)
        temp = zeros(1,N_frame);
        temp(1) = i;
        current = i;
        j = 2;
        while ~isempty(Molecule(current).To)
            temp(j) = Molecule(current).To;
            current = Molecule(current).To;
            j = j+1;
        end
        path = temp(find(temp));
        traj(k).trajectory = path;
        k = k+1;
    end
end