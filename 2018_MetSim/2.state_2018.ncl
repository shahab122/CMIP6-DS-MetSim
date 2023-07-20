load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_UTILS/geodiag_plot_utils.ncl"


begin

  starttime = 1005
  endtime   = 1094
  nday = 90
  nx = 250
  ny = 135

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


f1      = addfile("pr_day_CESM2_ssp126_r10i1p1f1_gn_20150101-21010101_cannc_SPQM_08.nc", "r")
f2      = addfile("tasmax_day_CESM2_ssp126_r10i1p1f1_gn_20150101-21010101_cannc_SPQM_08.nc", "r")
f3      = addfile("tasmin_day_CESM2_ssp126_r10i1p1f1_gn_20150101-21010101_cannc_SPQM_08.nc", "r")
f4      = addfile("time_tasmax_CESM2.nc", "r")

YYYY = ut_calendar(f4->time(time|starttime:endtime),-2)
print(YYYY)

print("tmax < tmin:     =============================================================")

prec   =f1->pr(time|starttime:endtime,lat|:,lon|:)        ; 2017.10.3-2017.12.31
tmax   =f2->tasmax(time|starttime:endtime,lat|:,lon|:)    
tmin   =f3->tasmin(time|starttime:endtime,lat|:,lon|:)    

printVarSummary(prec)

prec&time = f4->time(time|starttime:endtime)
tmax&time = f4->time(time|starttime:endtime)
tmin&time = f4->time(time|starttime:endtime)
printVarSummary(prec)


count =0
maxd = 0.

do it = 0, nday - 1
   do j = 0, nx - 1
     do k = 0, ny - 1
       if (tmax(it,k,j) .lt. tmin(it,k,j)) then
	 print("Wrong:" + "tmax = "+tmax(it,k,j) +" < " + "tmin = " +tmin(it,k,j)+", at grid ["+k+","+j+"]" ) 
          var = tmax(it,k,j)
	  tmax(it,k,j) = tmin(it,k,j)	
	  tmin(it,k,j) = var
	  count = count +1

          if (maxd .lt. (tmax(it,k,j) - tmin(it,k,j))) then
            maxd = tmax(it,k,j) - tmin(it,k,j)
	  end if

	end if
end do
end do
end do
print(count)
print(maxd)


fout      = addfile("region_08_state_2018.nc", "c")

fout->prec = prec
fout->t_max = tmax
fout->t_min = tmin
fout->lon = f1->lon
fout->lat = f1->lat
fout->time =f4->time(time|starttime:endtime)

end
