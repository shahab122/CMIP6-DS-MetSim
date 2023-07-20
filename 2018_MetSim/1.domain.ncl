load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_UTILS/geodiag_plot_utils.ncl"

begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

f1      = addfile("region_08_mask.nc", "r")
f2      = addfile("region_08_elev.nc", "r")

msk  =  f1->mask(:,:)
ele  =  f2->elev(:,:)

fout      = addfile("region_08_domain.nc", "c")
fout->mask = msk
fout->elev = ele
fout->lon = f1->lon
fout->lat = f1->lat


end
