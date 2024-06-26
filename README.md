<h1 align="center"><strong>Closet Ai | Revamp your style effortlessly</strong></h1>
<div align="center">
  <img src="https://i.ibb.co/QrHCr6T/supabase.png" alt="Syno Logo" width="200"/>
  <img src="https://i.ibb.co/Y01y0fc/flutter-logo.png" alt="Flutter Logo" width="200"/>
</div>

<p align="center">
  <img src="https://i.postimg.cc/Bngk2Dd8/promo-full.jpg" height="290"/>
  
</p>



<br/>
<p align="center">
  <a href="https://drive.google.com/file/d/1VH6hNLjEf9rv1LEzmuWvthVoz3jKkaEz/view?usp=sharing">Demo APK Download Link</a>
</p>

<br/>
<br/>
<img width="120" alt="app-icon" src="https://i.postimg.cc/pTVS0TM0/logo.png">


# 👾 ClosetAi - Your Virtual Wardrobe

Introducing Closet AI: the ultimate style companion 🌟. Upload images, choose your desired topwear or bottomwear, then watch as our cutting-edge AI replaces your outfit in an instant! 🔥 Seamlessly integrated with Supabase for secure authentication, lightning-fast image storage, and dynamic edge functions, our project is a game-changer for the Supabase Hackathon. Join us and revolutionize your wardrobe with the power of AI and Supabase!

**Designed with ❤️ for Supabase Open Source Hackathon 2024**

## 🔥 Supercharged with

- Supabase
- Flutter

## 💚 Usage of Supabase
In our app, Supabase serves as the backbone for secure user authentication, efficient image storage, and enables dynamic edge functions, ensuring seamless and reliable functionality for our users' virtual wardrobe transformations.

## 🚀 Examples

<img src='https://i.postimg.cc/BvgBshR0/example-1.png' width="600" border='0' alt='thumbnail'/><br/>
<img src='https://i.postimg.cc/63pLQrNG/example-2.png' width="600" border='0' alt='thumbnail'/><br/>

## 📺 Watch Demo

[Youtube Link](https://youtu.be/pJiE1EnM6w8)<br/><br/>
<a href='https://youtu.be/pJiE1EnM6w8' target='_blank'><img src='https://i.postimg.cc/wMRPb8M2/thumbnail.png' width="600" border='0' alt='thumbnail'/></a>


## Quick Look 👀
![Promo 2 Image](https://i.postimg.cc/T3YTP14W/promo-2.png)

|                                                                                                                                                                         |                                                                                                                                                                         |                                                                                                                                                                         |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/d1P4tkV2/IMG-7387.png"> | <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/6qBcnkRT/IMG-7397.png"> | <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/hG72Bbc4/Screenshot-2024-04-22-at-10-48-08-PM.jpg"> |
| <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/qRsQtJN9/IMG-7392.png"> | <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/m22VDGB5/IMG-7389.png"> | <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/QCSbbfkm/IMG-7391.png"> |
| <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/8kbtNCQv/IMG-7395.png"> | <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://i.postimg.cc/Vkz3Fh9y/IMG-7393.png"> 



# How to setup **ClosetAi** ?

## Setup Instructios: Supabase

### 1. Create Profile table:

```sql
create table
  profile (
    id bigint primary key generated always as identity,
    username text not null,
    email text not null,
    date_joined timestamp with time zone default current_timestamp
  );
```

### 2. Create the storage bucket 'closet-generations'

### 3. Add Bucket Policies:
```sql
-- Add policies for managing access to the storage bucket 'closet-generations'

create policy "Generations images are publicly accessible." on storage.objects
  for select using (bucket_id = 'closet-generations');

create policy "Anyone can upload an generations." on storage.objects
  for insert with check (bucket_id = 'closet-generations');

create policy "Anyone can update their own generations." on storage.objects
  for update using ((select auth.uid()) = owner) with check (bucket_id = 'closet-generations');
```

## Setup Instructios: Flutter 

### 1. Copy Environment Variables:

Copy the contents of `env.example` to a new file named `.env`.

```plaintext
REPLICATE_KEY=''
SUPABASE_URL=''
SUPABASE_ANON_KEY=''
```
Get the keys for REPLICATE_KEY, SUPABASE_URL, and SUPABASE_ANON_KEY from your Supabase project and Replicate dashboard
Replace the placeholders in the .env file with the actual keys. Then Continue with below steps

1. Install [Flutter](https://flutter.dev/docs/get-started/install) for your platform.
2. Clone this repository or download the source code.
3. Open a terminal window and navigate to the project directory.
4. Run `flutter pub get` to install dependencies.
5. Copy the Contents of .
6. Run `flutter run` to start the app.

## Roadmap

- Refactor the whole Codebase 😅
- Add Webhooks for triggering Emails when Generations are completed
- Add Supabase magic login
- Implement Local Image saving


## 🧑🏻‍💻 Team

- [Samuel Philip](https://github.com/ineffablesam)
- [Anish](https://github.com/anishganapathi)
- [Satyanand](https://github.com/SatyanandAtluri)
- [Team Next](https://github.com/Team-NEXT-INDIA/VITOPIA)

## 🔗 My Social Links

- [Twitter](https://twitter.com/samuelP09301972)
- [Instagram](https://www.instagram.com/ig_samuelsam/)
- [Github](https://github.com/ineffablesam/)
