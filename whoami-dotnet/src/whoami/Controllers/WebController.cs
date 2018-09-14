using System;
using System.Net;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace whoami.Controllers
{
    [Route("/")]
    [Controller]
    public class WebController : ControllerBase
    {
        [HttpGet]
        public ActionResult<string> Get()
        { 
            var host = Dns.GetHostName();
            var osDescription = RuntimeInformation.OSDescription;
            return $"I'm {host} running on {osDescription}";
        }
    }
}
