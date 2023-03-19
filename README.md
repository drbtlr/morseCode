# morseCode

An R package that translates text into International Morse Code symbols (and vice versa).

## Installation

The development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("drbtlr/morseCode")
```
## Example

``` r
library(morseCode)
```

``` r
# Convert text to Morse Code
text_to_code("hello world!")
#> .... . .-.. .-.. ---    .-- --- .-. .-.. -.. -.-.--
```

``` r
# Convert Morse Code to text
code_to_text(".... . .-.. .-.. ---    .-- --- .-. .-.. -.. -.-.--")
#> hello world!
```



