
https://user-images.githubusercontent.com/90014847/235641562-67a09617-c1b6-4438-a38c-d1533326a43c.mp4


ima
===

```
Usage: ima [OPTIONS] QUERY [QUERY...]

Options:
  --version                       Print program version and exit.
  -h, --help                      Print this help text and exit.
  -v, --verbose                   Print status messages to the standard output.
  -e, --engine ENGINE             Comma separated list of search engines to use,
                                  possible search engines are duckduckgo,
                                  google, and yahoo. Engine defaults to
                                  "google". If more than one search engine is
                                  specified, cycle through when connection fails
                                  too much.
  -n NUM                          Print NUM results obtained from the `-s' or
                                  `-i' option or download NUM images when
                                  neither of these options were specified.
  -u, --number-sites NUM          The number of websites to visit.
  -p, --no-progress-bar           Disable progress bar for downloads.
  -l, --image-link OUTPUT_FORMAT  Output image links instead of downloading
                                  them. You can use the following specifiers to
                                  format output: `{s}' represents the score of
                                  the given image, `{d}' its description, `{l}'
                                  its url, `{e}' its file extension and `{w}'
                                  the url from which the image link was
                                  extracted e.g: we can for example format our
                                  output as such --> "image {l} has score {s}".
  -s, --search-only               Query search engine and output search results
                                  only. This option is in conflict with the `-l'
                                  option.
  -m, --image-count NUM           Set NUM as maximum number of image links to be
                                  extracted from a website.
  -d, --dest-dir DEST_DIR         Specify the destination directory were
                                  downloaded files will be stored, default to
                                  the current working directory of the executing
                                  program.
  -o, --min-score SCORE           Define mininum score for images. This option
                                  should not be used with the `-s' option.
  -r, --retries NUM               Number of retries before giving up if any
                                  connection fails.
  -x, --retries-per-sites NUM     Number of retries per sites if any connection
                                  fails.
  -i, --ignore-domains DOMAIN     A comma separated list of domains to ignore on
                                  search results.
  -w, --overwrite                 Overwrite existing files, This option is in
                                  conflict with the `-a' option.
  -a, --auto-name                 Auto generate a new file name if a file name
                                  already exist in filesystem.
  -k, --no-color                  Disable ANSI colors
  -t, --timeout TIMEOUT           Set connection timeout.
  -q, --less-lines                Wipe download progress bar after download has
                                  finished
```

Image searcher and downloader

- [Introduction](https://github.com/tcheukueppo/ima#Introduction)
- [Installation](https://github.com/tcheukueppo/ima#Installation)
- [Documentation](https://github.com/tcheukueppo/ima#Documentation)
- [License](https://github.com/tcheukueppo/ima#License)
- [Authors](https://github.com/tcheukueppo/ima#Authors)

ima is an extremely tiny python library command line utility which permits you to query search engines(e.g DuckDuckGo)
and download images from web pages.

ima might be a utility of choice for the following purpose:

- Downloading images from the internet to build up your dataset
- Searching on the internet with Google, DuckDuckGo or Yahoo. You would want to
  use multiple search engines to obtain better results.
- Caching your search results to later on use them locally.

# Installation

```{python}
pip install ima-search
```

# Documentation

Read the documentation from [here](./docs/introduction.md)

# License

ima is licensed under GPLv3

# Authors

Kueppo Tcheukam, tcheukueppo@tutanota.com
