% Brian Knotten
% CS1675
% Homework 9

% A = the transition matrix (from hmm_starter.m)
% B = the observation matrix (from hmm_starter.m)
% N = the number of states
% M = the number of words in the vocabulary
% sent = the vector of integers representing the sentence whose observation probability we want to compute
% prob = the probability of observing the input sentence

function [prob] = naive_solution(A, B, N, M, sent)

  % Get the length of the sentence i.e. the number of words in the sentence
  numWords = length(sent);

  % Create a vector of numbers corresponding to the states
  states = 1:N;
  
  % Generate all possible permutations (with repetition) of the states
  repPerm = permn(states, numWords);
  permSize = size(repPerm);
  numPerm = permSize(1);

  % Column vector to store the products of the permutation probabilities
  products = zeros(numPerm, 1);

  % Compute the probability of a given state sequence
  % For each permutation
  for i = 1:numPerm
    % The probability of going from the start state to the first state
    products(i) = A(1, repPerm(i, 1)+1);
    if numWords > 1
      % The probability of going from the first state to the second, second
      % to the third, third to fourth, etc.
      for j = 1:numWords-1
	products(i) = products(i) * A(repPerm(i, j)+1, repPerm(i, j+1)+1);
      end
    end
    % The probability of going from the last state to the end state
    products(i) = products(i) * A(repPerm(i, numWords)+1, 6);

    % Compute the probability of observing the words at each state
    for k = 1:numWords
      products(i) = products(i) * B(repPerm(i, k), sent(k));
    end
  end
  prob = sum(products);
