#' Convert Morse Code symbols to text
#'
#' @description
#' This function converts a character vector of Morse Code symbols and prints
#' the equivalent text in the console. The function uses the International Morse Code
#' encoding for 26 letters, 10 numerals, and 15 punctuation marks.
#' @param string Input vector. Either a character vector, or something
#' coercible to one.
#' @return None (invisible `NULL`).
#' @import stringr
#' @import purrr
#' @export
#' @examples
#' my_code <- ".... . .-.. .-.. ---"
#' code_to_text(my_code)
code_to_text <- function(string) {
  # error
  stopifnot("Input must be character" = is.character(string))

  # define dictionary
  morse_dict <- data.frame(
    en = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
           "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
           "&", "'", "@", ")", "(", ":", ",", "=", "!", ".", "-", "+", '""', "?", "/"),
    cw = c(".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..",
           "-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----.",
           ".-...", ".----.", ".--.-.", "-.--.-", "-.--.", "---...", "--..--", "-...-", "-.-.--", ".-.-.-", "-....-", ".-.-.", ".-..-.", "..--..", "-..-.")
  )

  # covert dictionary to vector
  geten <- morse_dict$en
  names(geten) <- morse_dict$cw

  # separate text into characters
  txt <- string %>% purrr::map(~stringr::str_split(.x, " ")) %>% unlist

  # define translator
  get_value <- function(mykey, mylookupvector) {
    myvalue <- mylookupvector[mykey]
    myvalue <- unname(myvalue)
    return(myvalue)
  }

  # convert to code
  out <-
    purrr::map_chr(txt[1:length(txt)], ~ get_value(.x, geten)) %>%
    # add space between words
    stringr::str_replace_na() %>%
    stringr::str_flatten() %>%
    stringr::str_replace_all(., "NA", " ")

  # print output
  cat(out)
}
