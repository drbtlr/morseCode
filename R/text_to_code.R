#' Convert text to Morse Code symbols
#'
#' @description
#' This function converts a character vector into equivalent
#' Morse Code symbols (called "dots" and "dashes" or "dits" and "dahs") and
#' prints them to the console. The function uses the International Morse Code
#' encoding for 26 letters, 10 numerals, and 15 punctuation marks.
#' @param string Input vector. Either a character vector, or something
#' coercible to one.
#' @return None (invisible `NULL`).
#' @import stringr
#' @import purrr
#' @export
#' @examples
#' my_text <- "hello world!"
#' text_to_code(my_text)
text_to_code <- function(string) {
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
  getcw <- morse_dict$cw
  names(getcw) <- morse_dict$en

  # separate text into characters
  txt <- stringr::str_extract_all(
    stringr::str_c(string, " "), stringr::boundary("character")
  )

  # define translator
  get_value <- function(mykey, mylookupvector) {
    myvalue <- mylookupvector[mykey]
    myvalue <- unname(myvalue)
    return(myvalue)
  }

  # convert to code
  out <-
    purrr::map(txt[1:length(txt)], ~ get_value(.x, getcw)) %>%
    unlist %>%
    # add space between words
    stringr::str_replace_na() %>%
    stringr::str_replace_all("NA", "  ")

  # print output
  cat(out)
}
