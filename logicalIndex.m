
% This is an example of how to do some logical indexing -- 
% how you can vectorize code that might use an nested for loop
% and an if statement.

%% What is Logical Indexing?
x = randperm(8)

% Create logical mask
idx = x>5
% Use this vector to index into x
x(idx)

% Can create the mask while indexing
x(x>5)


%%  Finding elements using logical matrices
% " While most indices are numeric, indicating a certain row or column
% number, logical indices are positional. That is, it is the position of 
% each 1 in the logical matrix that determines which array element is 
% being referred to " 

N = 2000;

A = magic(N);  
A2 = magic(N);
A3 = magic(N);

myRef = 1e6; 

%%  Using an if and a nested for loop 
%  In this example we want to find all values that are over myRef.
%  This is how we do that in a nested for loop with an if-statement:

tic

ix = 1;

vals = zeros(size(A(:)));

for jj = 1:N
    for ii = 1:N
        if A(ii,jj) > myRef
            vals(ix) = A(ii,jj);
            ix = ix + 1;
        end
    end
end

vals(ix:end) = [];  %#ok<NASGU>

t1 = toc;
disp(['Using if and nested for loop: ' num2str(t1) ' sec, x' num2str(t1/t1)])

%%  Using the find Function

% "The find function determines the indices of array elements that meet 
% a given logical condition. It returns the indices in the form of linear
% indexing " 

myIndex = find(A2 > myRef);

tic
vals = A2(find(A2 > myRef));
t2 = toc;
disp(['Using the find Function: ' num2str(t2) ' sec , x' num2str(t1/t2)])

%% Using Logical Indexing
tic

vals = A3(A3 > myRef); %#ok<NASGU>
  
t3 = toc;
disp(['Using Logical Indexing: ' num2str(t3) ' sec , x' num2str(t1/t3)])

