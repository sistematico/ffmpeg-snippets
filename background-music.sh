#!/usr/bin/env bash
#
# Arquivo: background-music.sh
#
# Feito por Lucas Saliés Brum a.k.a. sistematico, <lucas@archlinux.com.br>
#
# Criado em: 15/02/2021 03:46:17
# Última alteração: 15/02/2021 03:46:12
#
# Fonte: https://stackoverflow.com/a/11783474/1844007

video=""
audio=""

# REPLACE AUDIO
#  video.mp4        output.mp4       audio.wav
# [  VIDEO  ] ---> [  VIDEO  ]
# [  AUDIO  ]      [  AUDIO  ] <--- [  AUDIO  ]
ffmpeg -i video.mp4 -i audio.wav -map 0:v -map 1:a -c:v copy -shortest output.mp4

# ADD AUDIO
#  video.mkv        output.mkv       audio.mp3
# [  VIDEO  ] ---> [  VIDEO  ]
# [  AUDIO  ] ---> [  AUDIO  ]
#                  [  AUDIO  ] <--- [  AUDIO  ]
ffmpeg -i video.mkv -i audio.mp3 -map 0 -map 1:a -c:v copy -shortest output.mkv

# MIXING/COMBINING TWO AUDIO INPUTS INTO ONE
#  video.mkv        output.mp4       audio.m4a
# [  VIDEO  ] ---> [  VIDEO  ]
# [  AUDIO  ] ---> [  AUDIO  ] <--- [  AUDIO  ]
ffmpeg -i video.mkv -i audio.m4a -filter_complex "[0:a][1:a]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 -shortest output.mkv