%uloha1
%isid92654
%Schwefel

space_down = ones(1,10) * -500; %lowest value
space_up = ones(1,10) * 500; %highest value
space = [space_down; space_up]; %space used for generating population
pop_size = 100; %population size(how many individuals)
num_of_best_ones = [15, 10, 5]; %how many individuals go to next generation (3x best, 2x second best, ...)
num_of_cycles = 800;

%toggles selection
selbest_toggle = 0;
seltourn_toggle = 1;
selsus_toggle = 0;
selrand_toggle = 0;
selection = get_selection(selbest_toggle, seltourn_toggle, selsus_toggle, selrand_toggle);

population = genrpop(pop_size,space); %generate population

fit_of_population = get_fit_of_population(pop_size, population);
best_individuals = zeros(1,pop_size);

hold on
for i = 1:num_of_cycles
    fit_of_population = get_fit_of_population(pop_size, population); %fitness
    best_individuals(i) = min(fit_of_population); %take best one for graph
    
    %selection of the best
    switch selection
        case 1
            new_population = selbest(population, fit_of_population, num_of_best_ones);
        case 2
            new_population = seltourn(population, fit_of_population, sum(num_of_best_ones));
        case 3
            new_population = selsus(population, fit_of_population, sum(num_of_best_ones));
        case 4
            new_population = selrand(population, fit_of_population, sum(num_of_best_ones));
    end 
    
    %crossing
    cross_pop = crossov(population, 1, 0);
    
    %mutation
    mut_pop = mutx(population, 0.5, space);
    
    %add to pop_size
    diff = (pop_size-(sum(num_of_best_ones))) /2;
    
    %take from crossed and mutated
    temp_pop1 = selrand(cross_pop, fit_of_population, diff);
    temp_pop2 = selrand(mut_pop, fit_of_population, diff);
    
    population = [new_population; temp_pop1; temp_pop2];
end

plot(best_individuals);

function sel = get_selection(best, tourn, sus, rand)
%returns:
%   1 for selbest    3 for selsus
%   2 for seltourn   4 for selrand

    %if 2 or more selection were toggled, display error message
    if (best + tourn + sus + rand) >= 2
        error('*** ERROR Please select only one selection ***');
    end
    
    if best == 1
        sel = 1;
    elseif tourn == 1
        sel = 2;
    elseif sus == 1
        sel = 3;
    else
        sel = 4;
    end
end 

function fit = get_fit_of_population(pop_size, population)
%returns matrix of function values
    fit = zeros(1,pop_size);
    
    for individ = 1:pop_size
        fit(individ) = testfn3(population(individ));
    end
end