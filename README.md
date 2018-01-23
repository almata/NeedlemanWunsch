# Needleman−Wunsch

_The Needleman–Wunsch algorithm is an algorithm used in bioinformatics to align protein or nucleotide sequences. It was one of the first applications of dynamic programming to compare biological sequences. The algorithm was developed by Saul B. Needleman and Christian D. Wunsch and published in 1970. The algorithm essentially divides a large problem (e.g. the full sequence) into a series of smaller problems and uses the solutions to the smaller problems to reconstruct a solution to the larger problem. It is also sometimes referred to as the optimal matching algorithm and the global alignment technique. The Needleman–Wunsch algorithm is still widely used for optimal global alignment, particularly when the quality of the global alignment is of the utmost importance._

Source: [Wikipedia](https://en.wikipedia.org/wiki/Needleman–Wunsch_algorithm)

This iOS app tries to be helpful for bioinformatics students to understand how the Needleman–Wunsch algorithm works, and has been programmed by Albert Mata, a bioinformatics student himself at UOC (Open University of Catalonia). The way it works is pretty straightforward: fill in the two sequences you want to align, optionally adjust the match/substitution/gap scoring system and tap on __Find global alignment__ (which actually happens to be the only button in the app). You will get the actual alignment (or one of them if there are more than one with the same score), its score and the grid.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/almata/NeedlemanWunsch/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-01-23%20at%2011.29.29.png" width="375" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/almata/NeedlemanWunsch/blob/master/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-01-23%20at%2011.30.28.png" width="375" />

The app is available [on the App Store]() _(to be added once Apple approves the app)_.