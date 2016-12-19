tmp: market_demo.m.log
#
SHELL=bash
#
PNG+=audiodemo1_fig1.png
PNG+=audiodemo1_fig2.png
PNG+=audiodemo1_fig3.png
LOG+=audio_demo1.m.log
audio_demo1.m.log: audio_demo1.m
	-(matlabtaco "addpath_scatnet;run('audio_demo1.m');exit;" |& tee $@)
#
LOG+=audio_demo2.m.log
audio_demo2.m.log: audio_demo2.m
	-(matlabtaco "addpath_scatnet;run('audio_demo2.m');exit;" |& tee $@)
#
LOG+=market_demo.m.log
market_demo.m.log: market_demo.m
	-(matlabtaco "addpath_scatnet;run('market_demo.m');exit;" |& tee $@)
#
all: $(LOG)
#
clean:
	-(rm -f $(PNG))
	-(rm -f $(LOG))
#
