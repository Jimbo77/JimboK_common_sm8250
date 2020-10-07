define __sec_dtbo_build
dtbo-$(2) += $(1)
$(1)-base := $(3)
endef

define sec_dtbo_build
$(foreach dtbo, $(1), $(eval $(call __sec_dtbo_build, $(dtbo),$(2),$(3))))
endef

QCOM_DTB := ../../vendor/qcom
SEC_KONA_BASE_DTB := $(QCOM_DTB)/kona.dtb $(QCOM_DTB)/kona-v2.dtb $(QCOM_DTB)/kona-v2.1.dtb

ifeq ($(CONFIG_BUILD_ARM64_DT_OVERLAY),y)

SEC_C1Q_KOR_DTBO := kona-sec-c1q-kor-overlay-r02.dtbo kona-sec-c1q-kor-overlay-r06.dtbo kona-sec-c1q-kor-overlay-r07.dtbo kona-sec-c1q-kor-overlay-r08.dtbo kona-sec-c1q-kor-overlay-r09.dtbo kona-sec-c1q-kor-overlay-r10.dtbo kona-sec-c1q-kor-overlay-r11.dtbo

$(eval $(call sec_dtbo_build, $(SEC_C1Q_KOR_DTBO),$(CONFIG_MACH_C1Q_KOR_SINGLE),$(SEC_KONA_BASE_DTB)))

endif
