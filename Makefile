ifeq ($(KERNELRELEASE),)

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

.PHONY: build clean

build:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

clean:
	rm -rf *.0 *~ .depend .*.cmd *.ko *.mod.c *.o
	rm -f modules.order Module.symvers

else

$(info Building with KERNELRELEASE = ${KERNELRELEASE})

obj-m			+= nvme-core.o
obj-m			+= nvme.o
obj-m			+= nvme-fabrics.o
obj-m			+= nvme-rdma.o
obj-m			+= nvme-fc.o

nvme-core-y				:= core.o
nvme-core-y				+= scsi.o
nvme-core-y				+= lightnvm.o

nvme-y					+= pci.o

nvme-fabrics-y				+= fabrics.o

nvme-rdma-y				+= rdma.o

nvme-fc-y				+= fc.o

endif
