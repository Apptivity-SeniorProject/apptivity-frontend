# Docker Kurulum Kılavuzu (Frontend)

Bu proje, React Native tabanlı hem web hem de mobil platformları destekleyen bir Expo uygulamasıdır. Bu dokümanda uygulamanın **Web** versiyonunun Docker üzerinde nasıl çalıştırılacağı açıklanmaktadır.

Uygulamanın çalışacağı port **8081** olarak ayarlanacaktır.

## 1. Gereksinimler

Sisteminizde aşağıdaki araçların kurulu olduğundan emin olun:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/) (Opsiyonel ama önerilir)

## 2. Docker İmajını Oluşturma (Build)

Uygulamanın kök dizininde (`apptivity-frontend` klasöründe) aşağıdaki komutu çalıştırarak Docker imajını oluşturun:

```bash
docker build -t apptivity-frontend .
```

*Not: İmajın boyutunu küçültmek ve güvenliği artırmak için `Dockerfile` çok aşamalı (multi-stage) build kullanmaktadır (Node.js + Nginx).*

## 3. Konteyneri Çalıştırma (Run)

İmaj oluşturulduktan sonra konteyneri başlatmak için aşağıdaki komutu kullanın. Uygulama localhost üzerinde **8081** portundan dışarıya açılacaktır.

```bash
docker run -d -p 8081:80 --name apptivity-frontend-app apptivity-frontend
```

Komut açıklaması:
- `-d`: Konteyneri arka planda çalıştırır.
- `-p 8081:80`: Bilgisayarınızın `8081` portunu Nginx\'in içerde çalıştığı `80` portuna bağlar.
- `--name apptivity-frontend-app`: Konteynere anlamlı bir isim verir.

### 4. Uygulamaya Erişim

Konteyner çalışmaya başladıktan sonra tarayıcınızdan şu adrese giderek uygulamaya erişebilirsiniz:

[http://localhost:8081](http://localhost:8081)

## 5. Konteyneri Durdurma ve Silme

Çalışan konteyneri durdurmak için:
```bash
docker stop apptivity-frontend-app
```

Durdurulmuş konteyneri silmek için:
```bash
docker rm apptivity-frontend-app
```

Eğer hem durdurup hem de silmek isterseniz (kısayol):
```bash
docker rm -f apptivity-frontend-app
```

---

*Not: Eğer Backend servisi (örn. localhost:8080 adresinden) ile iletişim kurulacaksa, uygulamanın `.env` veya API konfigürasyon dosyalarına backend adresinin `http://localhost:8080$` (veya Docker ortamındaki backend ağ adınız) olarak verildiğinden emin olun.*
