# Waiting for Mark

Github repo for analysing differences between scheduled and actual start times for Mark McGowan press conferences between December 1 2020 and July 3 2021.

Any additional data or data analysis welcome, just open a PR!

## Notes:

Data from the ABC News Yotube channel was scraped using the Youtube API; see the `livestream_data.py` file. A few amendments were made where the [@whattimemark](https://twitter.com/WhatTimeMark) twitter account provided an official scheduled time that differed to the time scheduled by the ABC News Youtube team. These are documented in the `livestream_wrangling.R` file.

Data from the ABC News Perth Facebook videos were input manually as the livestreams varied on whether the broadcast started when Mark began or beforehand (i.e., the broadcasting start time did not necessarily reflect the time Mark arrived).
