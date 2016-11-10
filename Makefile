ifeq ($(KERNELRELEASE),)

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

.PHONY: build clean

build:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

clean:
	rm -rf *.0 *~ core .depend .*.cmd *.ko *.mod.c *.o
	rm -f modules.order Module.symvers

else

$(info Building with KERNELRELEASE = ${KERNELRELEASE})

obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o

nvme-core-y				:= core.o
nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
nvme-core-$(CONFIG_NVM)			+= lightnvm.o

nvme-y					+= pci.o
nvme-fabrics-y				+= fabrics.o
nvme-rdma-y				+= rdma.o

endif

