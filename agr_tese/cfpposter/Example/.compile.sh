#!/bin/bash
file=$1
latex $1 && dvipdf poster.dvi poster_pdf.pdf && okular poster_pdf.pdf && clear

