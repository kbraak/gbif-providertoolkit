<#include "/WEB-INF/pages/inc/header.ftl">
<title><@s.text name="title"/></title>

<link rel="stylesheet" href="${baseURL}/styles/leaflet/leaflet.css" />
<link rel="stylesheet" href="${baseURL}/styles/leaflet/locationfilter.css" />
<script src="${baseURL}/js/leaflet/leaflet.js"></script>
<script src="${baseURL}/js/leaflet/tile.stamen.js"></script>
<link rel="stylesheet" href="${baseURL}/styles/select2/select2-4.0.13.min.css">
<link rel="stylesheet" href="${baseURL}/styles/select2/select2-bootstrap4.min.css">
<script src="${baseURL}/js/select2/select2-4.0.13.min.js"></script>

<script>
    $(document).ready(function(){
        <#if latitude?? && longitude??>
        var map = L.map('locationMap').setView([${latitude}, ${longitude}], 10).setMaxBounds(L.latLngBounds(L.latLng(-90, -180), L.latLng(90, 180)));
        var layer = new L.StamenTileLayer("terrain");
        map.addLayer(layer, {
            detectRetina: true
        });
        L.Icon.Default.imagePath = '${baseURL}/images/leaflet';
        var marker = L.marker([${latitude}, ${longitude}], {iconUrl: 'marker-icon-2x.png'}).addTo(map);
        </#if>

        $("#defaultLocale").select2({
            placeholder: '',
            language: {
                noResults: function () {
                    return '${selectNoResultsFound}';
                }
            },
            width: "100%",
            minimumResultsForSearch: 'Infinity',
            theme: 'bootstrap4'
        });
    });
</script>

<#assign currentMenu = "admin"/>
<#include "/WEB-INF/pages/inc/menu.ftl">
<#include "/WEB-INF/pages/macros/forms.ftl">

<div class="container px-0">
    <#include "/WEB-INF/pages/inc/action_alerts.ftl">
</div>

<form class="topForm half needs-validation" action="config.do" method="post" >
    <div class="container-fluid bg-body border-bottom">
        <div class="container bg-body border rounded-2 mb-4">
            <div class="container my-3 p-3">
                <div class="text-center">
                    <div class="fs-smaller">
                        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                            <ol class="breadcrumb justify-content-center mb-0">
                                <li class="breadcrumb-item"><a href="${baseURL}/admin/"><@s.text name="breadcrumb.admin"/></a></li>
                                <li class="breadcrumb-item"><@s.text name="breadcrumb.admin.settings"/></li>
                            </ol>
                        </nav>
                    </div>

                    <h1 class="pb-2 mb-0 pt-2 text-gbif-header fs-2 fw-normal">
                        <@s.text name="admin.home.editConfig"/>
                    </h1>

                    <div class="mt-2">
                        <@s.submit cssClass="button btn btn-sm btn-outline-gbif-primary top-button" name="save" key="button.save"/>
                        <a href="${baseURL}/admin/" class="button btn btn-sm btn-outline-secondary top-button">
                            <@s.text name="button.back"/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <main class="container main-content-container">
        <div class="my-3 p-3 ">
            <div class="row g-3">
                <div class="col-lg-6">
                    <@readonly name="dataDir" i18nkey="admin.config.server.data.dir" value="${dataDir}" help="i18n"/>
                </div>

                <div class="col-lg-6">
                    <@select name="defaultLocale" value="${defaultLocale!'en'}" options=defaultLocales help="i18n" i18nkey="admin.config.defaultLocale" includeEmpty=false />
                </div>

                <div class="col-lg-6">
                    <@input name="adminEmail" i18nkey="admin.config.adminEmail" help="i18n" size=80/>
                </div>

                <div class="col-lg-6">
                    <@input name="baseUrl" i18nkey="admin.config.baseUrl" help="i18n" size=80/>
                </div>

                <div class="col-lg-6">
                    <@input name="proxy" i18nkey="admin.config.proxy" help="i18n" size=80/>
                </div>

                <div class="col-lg-6">
                    <@input name="analyticsKey" i18nkey="admin.config.analyticsKey" help="i18n" size=80/>
                </div>

                <div class="col-12">
                    <@checkbox name="debug" i18nkey="admin.config.debug" value="${debug?c}" help="i18n"/>
                </div>

                <div class="col-12">
                    <@checkbox name="archivalMode" i18nkey="admin.config.archivalMode" value="${archivalMode?c}" help="i18n"/>
                </div>

                <div class="col-lg-6">
                    <@input name="archivalLimit" i18nkey="admin.config.archivalLimit" help="i18n" type="number"/>

                </div>

                <div class="col-lg-6">
                    <@readonly name="logDir" i18nkey="admin.config.server.log.dir" value="${logDir}" help="i18n"/>
                </div>

                <div class="col-lg-6">
                    <@readonly name="registryUrl" i18nkey="admin.config.registry.url" value="${registryUrl}" help="i18n"/>
                </div>

            </div>

            <div id="location" class="row g-3 mb-3 mt-2">
                <label for="latitude"><@s.text name="admin.config.server.location"/></label>
                <div class="col-lg-6">
                    <@input name="latitude" i18nkey="admin.config.server.latitude" help="i18n" />
                </div>
                <div class="col-lg-6">
                    <@input name="longitude" i18nkey="admin.config.server.longitude" help="i18n" />
                </div>
            </div>

            <#if latitude?? && longitude??>
                <#-- the map -->
                <div id="locationMap" class="mt-0"></div>
            <#else>
                <div class="mt-0" >
                    <img src="${baseURL}/images/ipt_no_location_map.gif"/>
                </div>
            </#if>
        </div>
    </main>
</form>

<#include "/WEB-INF/pages/inc/footer.ftl">
