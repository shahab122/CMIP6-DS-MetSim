import xarray as xr

#1. Check the NetCDF file and existing variables (without wind data)
# Load the netCDF file
file_path = "CanESM5_ssp245_r1i1p2f1_gn_20150101-21001231_cannc_SPQM_metsim_07_20150401-20151231.nc"  # Replace with your actual file path and the actual NetCDF file name
ds = xr.open_dataset(file_path)

# See what variables are included
print("Variables in netCDF file:")
print(ds.data_vars)

# Check dimensions
print("Dimensions:", ds.dims)

# 2. Create the new variable (same shape as time x lat x lon)
wind_speed = xr.DataArray(
    data=1.0,  # constant value
    dims=("time", "lat", "lon"),
    coords={"time": ds.time, "lat": ds.lat, "lon": ds.lon},
    name="wind_speed",
    attrs={"units": "m/s", "description": "Constant wind speed placeholder"}
)

# Add it to the dataset
ds["wind_speed"] = wind_speed

#3. Create the new NetCDF file with constant wind speed
output_path = "CanESM5_ssp245_r1i1p2f1_gn_20150101-21001231_cannc_SPQM_metsim_07_20150401-20151231+wind.nc" #Replace with your desired file name 
ds.to_netcdf(output_path)
print(f"✅ Updated netCDF file saved at: {output_path}")


# 4. Load the newly created netCDF file
file_path = "CanESM5_ssp245_r1i1p2f1_gn_20150101-21001231_cannc_SPQM_metsim_07_20150401-20151231+wind.nc"  # Replace with your actual file path
ds = xr.open_dataset(file_path)

# See what variables are included
print("Variables in netCDF file:")
print(ds.data_vars) #See if wind_speed variable has been added to the netcdf file or not

