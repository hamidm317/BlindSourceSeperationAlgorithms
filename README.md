# BlindSourceSeperationAlgorithms

This Repository contains some basic function in implementing some classic algorithms of blind source seperation (Linear mixtures). At the end of this file, I referenced to paper and books, that algorithms have been implemented base on their descriptions.

## Blind Source Seperation, based on mutual information minimization

We can seperate sources by minimizing mutual information between them (assuming that sources are statistically independent), so main idea is to find a matrix, multiplying to sensor samples, we have source samples! [1]

### Equivariant MI

In this type of algorithms, output matrix, is not dependant on mixing matrix, whether it is well mixed, or a small copy of other sources is in mixture of sources.

### Non-Equivariant MI

In this ones, output matrices are dependant, but easier to implement.

## EASI algorithm

Equivariant Adaptive Source Seperation algorithm, first presented by J. F. Cardoso [2].

## Fast ICA

Most common seperation algorithm, this implementation have been tested on sound and image. [3]

# References

[1] [Blind signal separation: statistical principles](https://ieeexplore.ieee.org/document/720250)
[2] [Equivariant adaptive source separation paper](https://ieeexplore.ieee.org/document/553476)
[3] [Hyvarinen Blind Source Seperation Text Book]
