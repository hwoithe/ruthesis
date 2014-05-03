
thesis: thesis.tex
	latex thesis.tex
	bibtex thesis
	latex thesis.tex
	latex thesis.tex

pdf: thesis 
	dvips -Ppdf -G0 -tletter thesis.dvi -o thesis.ps
	ps2pdf -dMAxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true \
	       -dPDFSETTINGS=/prepress -dUseFlateCompression=true \
	       -sPAPERSIZE=letter -dOptimize=true -dCompatibilityLevel=1.4 \
	       -sOutputFile=thesistmp.pdf \
	       thesis.ps pdfmarks
	pdftk thesistmp.pdf update_info report.txt output thesis.pdf
	rm thesistmp.pdf
	rm thesis.ps

# /screen, /ebook, /printer, /prepress
pdfsmall: thesis.pdf
	gs					\
	  -q -dNOPAUSE -dBATCH -dSAFER		\
	  -sDEVICE=pdfwrite			\
	  -dCompatibilityLevel=1.4		\
	  -dPDFSETTINGS=/screen			\
	  -dEmbedAllFonts=true			\
	  -dSubsetFonts=true			\
	  -dColorImageDownsampleType=/Bicubic	\
	  -dColorImageResolution=72		\
	  -dGrayImageDownsampleType=/Bicubic	\
	  -dGrayImageResolution=72		\
	  -dMonoImageDownsampleType=/Bicubic	\
	  -dMonoImageResolution=72		\
	  -sOutputFile="thesissmalltmp.pdf"	\
	  "thesis.pdf"
	pdftk thesissmalltmp.pdf update_info report.txt output thesis_small.pdf
	rm thesissmalltmp.pdf

titlepage: thesis.pdf
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
	 -dFirstPage=1 -dLastPage=1 \
	 -sOutputFile=titlepage.pdf thesis.pdf 

clean:
	rm *.aux *.dvi *.ps *~ *.pdf *.bbl *.log *.lot *.out *.toc *.lof *.blg