### cli_abort() makes it easy to mix text and value ----------------------------

# Glue interpolation
x <- 10
cli::cli_abort("x ({x}) must be less than 10.")

# With styling
path <- "foo.txt"
cli::cli_abort("{.arg path} ({.path {path}}) doesn't exist.")
cli::cli_abort("{.arg x} must be a string, not {.obj_type_friendly {x}}.")
# https: /cli.r-lib.org/reference/inline-markup.html

### Pluralisation is a breeze --------------------------------------------------

n_files <- 1
cli::cli_abort("Can't supply {n_files} file{?s}.")

n_files <- 2
cli::cli_abort("Can't supply {n_files} file{?s}.")

### It’s easy to add link ------------------------------------------------------

cli::cli_abort("See {.url https: /cli.r-lib.org} for details.")
cli::cli_abort("See {.fun stats :lm} to learn more.")
cli::cli_abort("See the tibble options at {.help tibble :tibble_options}.")

# Including links that run code
cli::cli_abort("Run {.run testthat :snapshot_review()} to review.")

# More at https: /cli.r-lib.org/reference/links.html#hyperlink-support

### Bulleted lists allow you to present multiple details -----------------------

content_type <- "character"
type <- "double"
suffix <- NULL

cli::cli_abort(c(
  "Unexpected content type {.str {content_type}}.",
  "*" = paste0("Expecting {.str {type}}",
               if (!is.null(suffix)) " or suffix {.str {suffix}}",
               "."),
  i = "Override check with {.code check_type = FALSE}."
))

# https: /cli.r-lib.org/reference/cli_bullets.html#details


### cli::cli_abort() automatically includes the function name ------------------
my_function <- function() {
  cli::cli_abort("An error")
}

my_function()


### But what if you write a helper? --------------------------------------------

my_error_helper <- function() {
  cli::cli_abort("An error")
}

my_function <- function() {
  my_error_helper()
}

my_function()

### You need to capture the caller environment and pass it along ---------------

my_error_helper <- function(call = parent.frame()) {
  cli::cli_abort("An error", call = call)
}

my_function <- function() {
  my_error_helper()
}

my_function()

