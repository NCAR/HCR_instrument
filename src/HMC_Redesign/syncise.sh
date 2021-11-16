#!/bin/bash


idir=/home/karboski/git/HCR_instrument/src/HMC_Redesign

oname=hmc_`date -r /home/karboski/git/HCR_instrument/src/HMC_Redesign/x_HMC_src.bit '+%Y%m%d_%H%M'`

odir=/h/eol/karboski/builds/hmc_r5/$oname

echo Copying to $odir
mkdir $odir

if [ $idir/x_HMC_src.mcs -ot $idir/x_HMC_src.bit ]
then
	echo WARNING: Flash image \(MCS\) out of date. Skipping.
else
	cp $idir/x_HMC_src.mcs $odir/$oname.mcs
fi

cp $idir/x_HMC_src.bit $odir/$oname.bit
cp $idir/HMC_cs.cdc $odir/$oname.cdc

rsync -avz -e 'ssh -p 26' /h/eol/karboski/builds/hmc_r5 apar@spol-router.eol.ucar.edu:/home/apar


