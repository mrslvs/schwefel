%uloha1
%isid92654
%Schwefel

space_down = ones(1,10) * -500;
space_up = ones(1,10) * 500;
space = [space_down; space_up];

pop_size = 100;

population = genrpop(pop_size,space);
fit_of_population = zeros(1, pop_size);

for individ = 1:pop_size
    fit_of_population(individ) = testfn3(population(individ));
end

function fit = get_fit_of_population(population, pop_size)
%returns matrix of function values
    fit = zeros(1,pop_size);
    
    for individ = 1:pop_size
        fit(individ) = testfn3(population(individ));
    end
end