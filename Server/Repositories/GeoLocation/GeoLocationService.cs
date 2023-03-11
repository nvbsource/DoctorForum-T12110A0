using Doctors_Forum_Server.DTOs.User;
using GoogleMaps.LocationServices;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
namespace Doctors_Forum_Server.Repositories.GeoLocation
{
    public class GeoLocationService : IGeoLocationService
    {
        private readonly GoogleLocationService _googleLocationService;

        public GeoLocationService(IConfiguration configuration)
        {
            var apiKey = configuration["GoogleApiKey"];
            _googleLocationService = new GoogleLocationService(apiKey);
        }

        public Geolocation? GetLatLongFromAddress(string address)
        {
            try
            {
                var point = _googleLocationService.GetLatLongFromAddress(address);
                if (point != null)
                {
                    return new Geolocation()
                    {
                        Latitude = point.Latitude,
                        Longitude = point.Longitude
                    };
                }
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return null;
            }
        }
        public double Distance(double lat1, double lon1, double lat2, double lon2)
        {
            var R = 6371; // radius of the earth in km
            var dLat = ToRadians(lat2 - lat1);
            var dLon = ToRadians(lon2 - lon1);
            var a =
                Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                Math.Cos(ToRadians(lat1)) * Math.Cos(ToRadians(lat2)) *
                Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
            var distance = R * c;
            return distance;
        }

        public double ToRadians(double angle)
        {
            return Math.PI * angle / 180.0;
        }
    }

    public interface IGeoLocationService
    {
        public Geolocation? GetLatLongFromAddress(string address);
        public double Distance(double lat1, double lon1, double lat2, double lon2);
    }
}
