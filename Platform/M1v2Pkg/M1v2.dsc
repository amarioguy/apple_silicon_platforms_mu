#M1v2 UEFI DSC file
#some parts borrowed from WOA-Project/SurfaceDuoPkg
#Disclaimer: probably not the best UEFI dev out there
#
#  Copyright (c) 2011-2015, ARM Limited. All rights reserved.
#  Copyright (c) 2014, Linaro Limited. All rights reserved.
#  Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.
#  Copyright (c) 2018, Bingxing Wang. All rights reserved.
#
#  This program and the accompanying materials
#  are licensed and made available under the terms and conditions of the BSD License
#  which accompanies this distribution.  The full text of the license may be found at
#  http://opensource.org/licenses/bsd-license.php
#
#  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
#  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#
#

#SPDX-License-Identifier: BSD 2-Clause

#Basic Defines

[Defines]
  PLATFORM_NAME                  = M1v2
  PLATFORM_GUID                  = d7d529ec-4827-494a-85e7-5900d9841a9e
  PLATFORM_VERSION               = 1.0
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/M1V2UEFI-$(ARCH)
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = M1v2Pkg/M1v2.fdf

  
  DEFINE SECURE_BOOT_ENABLE      = FALSE #disable secure boot for now
  DEFINE AIC_BUILD               = FALSE #AIC build disabled by default, change to true if you want AIC support


[BuildOptions.common]
  GCC:*_*_AARCH64_CC_FLAGS = -DSILICON_PLATFORM=6000
  *_*_*_CC_FLAGS = -D DISABLE_NEW_DEPRECATED_INTERFACES -D HAS_MEMCPY_INTRINSICS

[PcdsPatchableInModule.common]
  #These will get overriden by the FDT settings
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x10000000000
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x400000000 #16GB RAM space by default
  gM1PkgTokenSpaceGuid.PcdFdtPointer|0x10200000000
  gArmTokenSpaceGuid.PcdFdBaseAddress|0x0
  gArmTokenSpaceGuid.PcdFvBaseAddress|0x0
  gAppleSiliconPkgTokenSpaceGuid.PcdAppleUartBase|0x39b200000
  
!include M1v2Pkg/M1v2Pkg.dsc.inc
!include AppleSiliconPkg/FrontpageDsc.inc