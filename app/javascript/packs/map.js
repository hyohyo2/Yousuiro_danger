// ブートストラップローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

// ライブラリの読み込み
let map;

async function initMap(){
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker")

  map = new Map(document.getElementById("map"), {
    center: { lat:34.666536, lng:133.9180779 },
    zoom: 15,
    mapId: "DEMO_MAP_ID",
    mapTypeControl: false
  });

  try {
    const response = await fetch("/posts/timeline.json");
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: {items} } = await response.json();
    if (!Array.isArray(items)) throw new Error("Items is not an array");

    items.forEach( item => {
      const latitude = item.latitude;
      const longitude = item.longitude;
      const prefectureAddress = item.prefecture_address;
      const cityAddress = item.city_address;
      const blockAddress = item.block_address;
      const i18nStatus = {
        danger: '危険',
        safety: '安全',
      };
      const status = i18nStatus[item.status];
      const postCode = item.post_code;

      const userImage = item.user.image;
      const userName = item.user.name;
      const Image = item.image;


      const marker = new google.maps.marker.AdvancedMarkerElement({
        position: { lat: latitude, lng: longitude },
        map,
        title: blockAddress,
      });

      const contentString =`
        <div class="information container p-0">
          <div class="mb-3 d-flex align-items-center">
            <img class="rounded-circle mr-2" src="${userImage}" width="40" height="40">
            <p class="lead m-0 font-weight-bold">${userName}</p>
          </div>
          <div class="mb-3">
            <img class="thumbnail" src="${Image}" width="400" height="300" loading="lazy">
          </div>
          <div>
            <h1 class="h4 font-weight-bold">${status}</h1>
            <p class="text-muted">〒${postCode.slice(0, 3)}-${postCode.slice(3)}</p>
            <p class="text-muted">${prefectureAddress},${cityAddress},${blockAddress}</p>
          </div>
        </div>
      `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: blockAddress,
      });

      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map,
        })
      });

    });
  } catch (error) {
    console.error('Error fetching or processing posts:', error);
  }
}

initMap()