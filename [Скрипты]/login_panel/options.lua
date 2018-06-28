--[[
	*Scripted by ZoRRoM^.
	*ZoRRoM^ tarafından kodlanmıştır.
	*Lütfen http://mtasa-tr.com adresini ziyaret edin.
	*Please visit http://mtasa-tr.com adress.
]]

login_options = {
	language = {
		["turkish"] = {
			[1] = "Войти",
			[2] = "Регистрация",
			[3] = "Логин",
			[4] = "Пароль",
			[5] = "С таким логином уже существует аккаунт.",
			[6] = "С таким именем не существует аккаунт.",
			[7] = "Неверный пароль.",
			[8] = "Слишком много/мало символов.",
			[9] = "Ошибка, собщите админу.",
			[10] = "Сох.",
			[11] = "Вы успешно зарегистрировали акаунт.",
			[12] = "На этот счет еще кто-то играет.",
			[13] = "Уберите кириллицу из логина."
		},
		["english"] = {
[1] = "Войти",
			[2] = "Регистрация",
			[3] = "Логин",
			[4] = "Пароль",
			[5] = "#00BF7CДанный #FFFFFFаккаунт уже #00BF7Cзарегистрирован #FFFFFFна этом сервере",
			[6] = "#00BF7CАккаунта #FFFFFFс таким #00BF7C #FFFFFFне #00BF7Cсуществует",
			[7] = "Неверный пароль.",
			[8] = "Слишком много символов.",
			[9] = "Ошибка, собщите админу.",
			[10] = "Сох.",
			[11] = "#00BF7CВы #FFFFFFуспешно создали новый #00BF7Cаккаунт",
			[12] = "#00BF7CКто-то #FFFFFFсейчас #00BF7Cиграет #FFFFFFна этом #00BF7Cаккаунте"
		},
		-- If you want to add your language, you can edit the above or you can create new table like the above.
	},
	selected_language = "turkish", --[[ [turkish/english/...]
									Kullanmak istediğiniz dili yazın.
									Write the language you want to use.
								]]
	
	theme_color = {235, 38, 38},
	effect_speed = 20,
	font_opt = {
		font = "default-bold", --[[ [default/default-bold/clear/arial/sans/pricedown/bankgothic/diploma/beckett/...]
								Başka fontlar kullanmak için: font = dxCreateFont(font konumu, font kalitesi)
								For use another fonts: font = dxCreateFont(font path, font quality)
							]]
		scale = 1 --[[ [sayı/number]
						Font büyüklüğü için: scale = boyut
						For font's size: scale = size
					]]
	},
	
	postGUI = true, --[[ [false/true]
						GUI elementinin üzerine çizilir. (eğer true ise)
						Drawn on the GUI elements. (if is true)
					]]
	
	
	login = false, --[[ [false/true]
						Oyuncu kayıt olduğunda otomatik giriş yapar. (eğer true ise)
						It makes auto login when player registered. (if is true)
					]]
	
	hide_chat = true, --[[ [false/true]
						Script açık iken sohbet penceresini kapatır. (eğer true ise)
						It is turn off chatbox while the script is open. (if is true)
					]]
	hide_radar = {
		on_start = true, --[[ [false/true]
						Script açıldığında, radar'ı kapatır. (eğer true ise)
						Script açıldığında, radar'ı açar. (eğer false ise)
						Script is opened, closes the radar. (if is true)
						Script is opened, open the radar. (if is false)
					]]
		on_stop = false --[[ [false/true]
						Script kapandığında, radar'ı kapatır. (eğer true ise)
						Script kapandığında, radar'ı açar. (eğer false ise)
						Script is stopped, closes the radar. (if is true)
						Script is stopped, open the radar. (if is false)
					]]
	},
	
	play_sound = {
		play = false, --[[ [false/true]
						Script açık iken sesi oynatır. (eğer true ise)
						It is play sound while the script is open. (if is true)
					]]
		sound_path = "welcome.mp3", --[[
						Dosya yolu veya URL yazınız. YouTUBE müzikleri için http://youtubeinmp3.com/fetch/?video=müzikadresi kullanabilirsiniz. Örnek: http://youtubeinmp3.com/fetch/?video=https://www.youtube.com/watch?v=eNmCKpJ52W0
						Write file path or URL. You can use http://youtubeinmp3.com/fetch/?video=songpath for YouTUBE's song. E.g: http://youtubeinmp3.com/fetch/?video=https://www.youtube.com/watch?v=eNmCKpJ52W0
					]]
		loop = false, --[[ [false/true]
						Sesi döngületir. (eğer true ise)
						It do looped sound. (if is true)
					]]
		stop_sound = true --[[ [false/true]
						Giriş yaptıktan sonra müziği durdurur. (Eğer true ise)
						It stop music after login. (if is true)
					]]
	},
	
	max_character = 20, -- Maksimum karakter [ Min 3 ][ Max 23 ]
	min_character = 5, -- Minimum karakter [ Min 3 ][ Max 23 ]
	
	use_only_ASCII = true, --[[ [false/true]
						Yalnızca İngilizce karakterler kullanılır. (eğer true ise)
						Used only English characters. (if is true)
					]]
	
	use_backround_image = true, --[[ [false/true]
						Arkaplan resmi kullanır. (eğer true ise)
						Used background image. (if is true)
					]]
	
	set_camera_position = {
		active_camera = false, --[[ [false/true]
						Script açık iken kamera pozisyonu kullanılır. Kullanıyorsanız, "use_backround_image" değerini false yapın. (eğer true ise)
						Used camera position while the script is open. If you use it, do false "use_backround_image"s value. (if is true)
					]]
		position = {-1735.6, 780.2, 168.9, -1734.7, 780.1, 168.6, 0, 70}, --[[ Kamera Pozisyonu - Camera Position
						Söz Dizimi - Syntax:
						{ float positionX, float positionY, float positionZ [, float lookAtX, float lookAtY, float lookAtZ, float roll = 0, float fov = 70 ] }
					]]
		set_camera_target = true, --[[ [false/true]
						active_camera = true ise, giriş yapıldıktan sonra kamera oyuncuya çevrilir. (eğer true ise)
						if active_camera = true, camera's target change to player. (if is true)
					]]
	}
}