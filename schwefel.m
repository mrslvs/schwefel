%uloha1
%isid92654
%Schwefel

space_down = ones(1,10) * -500; %lowest value
space_up = ones(1,10) * 500; %highest value
space = [space_down; space_up]; %space used for generating population
pop_size = 100; %population size(how many individuals)
num_of_best_ones = [20, 15, 10, 5]; %how many individuals go to next generation (20x best, 15x second best, ...)
num_of_cycles = 500;


population = genrpop(pop_size,space); %generate population

fit_of_population = get_fit_of_population(pop_size, population);
best_individuals = zeros(1,pop_size);

for i = 1:num_of_cycles
    fit_of_population = get_fit_of_population(pop_size, population);
    best_individuals(i) = min(fit_of_population);
    new_population = selbest(population, fit_of_population, num_of_best_ones);
end


function fit = get_fit_of_population(pop_size, population)
%returns matrix of function values
    fit = zeros(1,pop_size);
    
    for individ = 1:pop_size
        fit(individ) = testfn3(population(individ));
    end
end