%uloha1
%isid92654
%Schwefel

space_down = ones(1,10) * -500;
space_up = ones(1,10) * 500;
space = [space_down; space_up];

pop_size = 100;

population = genrpop(pop_size,space);