LIBVPX_TEST_SRCS-yes += acm_random.h
LIBVPX_TEST_SRCS-yes += clear_system_state.h
LIBVPX_TEST_SRCS-yes += codec_factory.h
LIBVPX_TEST_SRCS-yes += md5_helper.h
LIBVPX_TEST_SRCS-yes += register_state_check.h
LIBVPX_TEST_SRCS-yes += test.mk
LIBVPX_TEST_SRCS-yes += test_libvpx.cc
LIBVPX_TEST_SRCS-yes += test_vectors.cc
LIBVPX_TEST_SRCS-yes += test_vectors.h
LIBVPX_TEST_SRCS-yes += util.h
LIBVPX_TEST_SRCS-yes += video_source.h

##
## BLACK BOX TESTS
##
## Black box tests only use the public API.
##
LIBVPX_TEST_SRCS-yes                   += ../md5_utils.h ../md5_utils.c
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += ivf_video_source.h
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += ../y4minput.h ../y4minput.c
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += aq_segment_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += datarate_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += error_resilience_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += i420_video_source.h
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += resize_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += y4m_video_source.h
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += yuv_video_source.h

LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += altref_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += config_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += cq_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += keyframe_test.cc

LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += byte_alignment_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += external_frame_buffer_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += invalid_file_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += user_priv_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += vp9_frame_parallel_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += active_map_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += borders_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += cpu_speed_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += frame_size_tests.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_lossless_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_end_to_end_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_ethread_test.cc

LIBVPX_TEST_SRCS-yes                   += decode_test_driver.cc
LIBVPX_TEST_SRCS-yes                   += decode_test_driver.h
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += encode_test_driver.cc
LIBVPX_TEST_SRCS-yes                   += encode_test_driver.h

## IVF writing.
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += ../ivfenc.c ../ivfenc.h

## Y4m parsing.
LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += y4m_test.cc ../y4menc.c ../y4menc.h

## WebM Parsing
ifeq ($(CONFIG_WEBM_IO), yes)
LIBWEBM_PARSER_SRCS                    += ../third_party/libwebm/mkvparser.cpp
LIBWEBM_PARSER_SRCS                    += ../third_party/libwebm/mkvreader.cpp
LIBWEBM_PARSER_SRCS                    += ../third_party/libwebm/mkvparser.hpp
LIBWEBM_PARSER_SRCS                    += ../third_party/libwebm/mkvreader.hpp
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += $(LIBWEBM_PARSER_SRCS)
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += ../tools_common.h
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += ../webmdec.cc
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += ../webmdec.h
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += webm_video_source.h
endif

LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += decode_api_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_DECODERS)    += test_vector_test.cc

# Currently we only support decoder perf tests for vp9. Also they read from WebM
# files, so WebM IO is required.
ifeq ($(CONFIG_DECODE_PERF_TESTS)$(CONFIG_VP9_DECODER)$(CONFIG_WEBM_IO), \
      yesyesyes)
LIBVPX_TEST_SRCS-yes                   += decode_perf_test.cc
endif

# encode perf tests are vp9 only
ifeq ($(CONFIG_ENCODE_PERF_TESTS)$(CONFIG_VP9_ENCODER), yesyes)
LIBVPX_TEST_SRCS-yes += encode_perf_test.cc
endif

##
## WHITE BOX TESTS
##
## Whitebox tests invoke functions not exposed via the public API. Certain
## shared library builds don't make these functions accessible.
##
ifeq ($(CONFIG_SHARED),)

## VP8
ifneq ($(CONFIG_VP8_ENCODER)$(CONFIG_VP8_DECODER),)

# These tests require both the encoder and decoder to be built.
ifeq ($(CONFIG_VP8_ENCODER)$(CONFIG_VP8_DECODER),yesyes)
LIBVPX_TEST_SRCS-yes                   += vp8_boolcoder_test.cc
LIBVPX_TEST_SRCS-yes                   += vp8_fragments_test.cc
endif

LIBVPX_TEST_SRCS-$(CONFIG_POSTPROC)    += pp_filter_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_DECODER) += vp8_decrypt_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += set_roi.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += subtract_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += variance_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += vp8_fdct4x4_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP8_ENCODER) += quantize_test.cc

LIBVPX_TEST_SRCS-yes                   += idct_test.cc
LIBVPX_TEST_SRCS-yes                   += intrapred_test.cc
LIBVPX_TEST_SRCS-yes                   += sixtap_predict_test.cc
LIBVPX_TEST_SRCS-yes                   += vpx_scale_test.cc

ifeq ($(CONFIG_VP8_ENCODER)$(CONFIG_TEMPORAL_DENOISING),yesyes)
LIBVPX_TEST_SRCS-$(HAVE_SSE2) += vp8_denoiser_sse2_test.cc
endif

endif # VP8

## VP9
ifneq ($(CONFIG_VP9_ENCODER)$(CONFIG_VP9_DECODER),)

# These tests require both the encoder and decoder to be built.
ifeq ($(CONFIG_VP9_ENCODER)$(CONFIG_VP9_DECODER),yesyes)
# IDCT test currently depends on FDCT function
LIBVPX_TEST_SRCS-yes                   += idct8x8_test.cc
LIBVPX_TEST_SRCS-yes                   += partial_idct_test.cc
LIBVPX_TEST_SRCS-yes                   += superframe_test.cc
LIBVPX_TEST_SRCS-yes                   += tile_independence_test.cc
LIBVPX_TEST_SRCS-yes                   += vp9_boolcoder_test.cc
LIBVPX_TEST_SRCS-yes                   += vp9_encoder_parms_get_to_decoder.cc
endif

LIBVPX_TEST_SRCS-$(CONFIG_VP9)         += convolve_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += vp9_thread_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_DECODER) += vp9_decrypt_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += dct16x16_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += dct32x32_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += fdct4x4_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += fdct8x8_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += variance_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_subtract_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += lpf_8_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_avg_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_error_block_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9_ENCODER) += vp9_quantize_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_VP9)         += vp9_intrapred_test.cc

ifeq ($(CONFIG_VP9_ENCODER),yes)
LIBVPX_TEST_SRCS-$(CONFIG_SPATIAL_SVC) += svc_test.cc
LIBVPX_TEST_SRCS-$(CONFIG_INTERNAL_STATS) += blockiness_test.cc
endif

ifeq ($(CONFIG_VP9_ENCODER)$(CONFIG_VP9_TEMPORAL_DENOISING),yesyes)
LIBVPX_TEST_SRCS-$(HAVE_SSE2) += vp9_denoiser_sse2_test.cc
endif

endif # VP9

LIBVPX_TEST_SRCS-$(CONFIG_ENCODERS)    += sad_test.cc

endif # CONFIG_SHARED

include $(SRC_PATH_BARE)/test/test-data.mk
