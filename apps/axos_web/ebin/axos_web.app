{application,axos_web,
             [{description,"axos_web"},
              {vsn,"1"},
              {modules,[axos_web,axos_web_app,axos_web_lookup,
                        axos_web_provenance,axos_web_register,
                        axos_web_resource,axos_web_sup]},
              {registered,[]},
              {applications,[kernel,stdlib,inets,crypto,mochiweb,webmachine]},
              {mod,{axos_web_app,[]}},
              {env,[]}]}.