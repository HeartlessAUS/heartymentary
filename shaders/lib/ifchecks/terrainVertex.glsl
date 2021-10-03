if (mc_Entity.x ==  31 || mc_Entity.x ==   6 || mc_Entity.x ==  59 || 
    mc_Entity.x == 175 || mc_Entity.x == 176 || mc_Entity.x ==  83 || 
    mc_Entity.x == 104 || mc_Entity.x == 105 || mc_Entity.x == 11019) // Foliage
    #ifdef NOISY_TEXTURES
        noiseVarying = 1001.0,
    #endif
    mat = 1.0, lmCoord.x = clamp(lmCoord.x, 0.0, 0.87), quarterNdotUfactor = 0.0;
    
if (mc_Entity.x == 18 || mc_Entity.x == 9600 || mc_Entity.x == 9100) // Leaves, Vine, Lily Pad
    #ifdef COMPBR
        specR = 12.065, specG = 0.003,
    #endif
    #ifdef NOISY_TEXTURES
        noiseVarying = 1001.0,
    #endif
    mat = 2.0;

if (mc_Entity.x == 10) // Lava
    #ifdef COLORED_LIGHT
        lightVarying = 3.0,
    #endif
    mat = 4.0,
    specB = 0.25, quarterNdotUfactor = 0.0, color.a = 1.0, lmCoord.x = 0.9,
    color.rgb = normalize(color.rgb) * vec3(LAVA_INTENSITY * 1.45);
if (mc_Entity.x == 1010) // Fire
    #ifdef COLORED_LIGHT
        lightVarying = 3.0,
    #endif
    specB = 0.25, lmCoord.x = 0.98, color.a = 1.0, color.rgb = vec3(FIRE_INTENSITY * 0.67);
if (mc_Entity.x == 210) // Soul Fire
    #ifdef COLORED_LIGHT
        lightVarying = 2.0,
    #endif
    #ifdef SNOW_MODE
        noSnow = 1.0,
    #endif
    specB = 0.25, lmCoord.x = 0.0, color.a = 1.0, color.rgb = vec3(FIRE_INTENSITY * 0.53);

if (mc_Entity.x == 12345) // Custom Emissive
    lmCoord = vec2(0.0), specB = 2.05;

if (mc_Entity.x == 300) // No Vanilla AO
    #ifdef NOISY_TEXTURES
        noiseVarying = 1001.0,
    #endif
    color.a = 1.0;

if (lmCoord.x > 0.99) // Clamp full bright emissives
    lmCoord.x = 0.9;

/*
if (lmCoord.x > 0.85) { // Reduce lightmap
    float lightmapO = max(lmCoord.x - 0.85, 0.0);
    lmCoord.x = 0.85 + lightmapO * 0.75, quarterNdotUfactor = 1.0 - lightmapO * 3.33333;
}
*/

#ifdef COMPBR
    if (mc_Entity.x < 10218.5) {
        if (mc_Entity.x < 10115.5) {
            if (mc_Entity.x < 10052.5) {
                if (mc_Entity.x < 10008.5) {
                    if (mc_Entity.x < 10002.5) {
                        if (mc_Entity.x == 10000) { // Grass Block
                            if (color.b < 0.99) { // Grass Block Grass
                                specR = 8.034, specG = 0.003;
                            } else { // Grass Block Dirt
                                specR = 2.035, specG = 0.003;
                            }
                        }
                        else if (mc_Entity.x == 10001) // Snowy Grass Block
                            mat = 105.0,
                            specR = 2.035;
                        else if (mc_Entity.x == 10002) // Sand
                            specR = 80.004, mat = 3.0;
                    } else {
                        if (mc_Entity.x == 10003) // Stone+, Coal Ore
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.77,
                            #endif
                            specR = 20.04;
                        else if (mc_Entity.x == 10007) // Dirt, Coarse Dirt, Podzol, Grass Path, Dirt Path, Farmland Dry
                            specR = 2.035, specG = 0.003;
                        else if (mc_Entity.x == 10008) // Glass, Glass Pane
                            specR = 0.8, lmCoord.x = clamp(lmCoord.x, 0.0, 0.87), mipmapDisabling = 1.0;
                    }
                } else {
                    if (mc_Entity.x < 10012.5) {
                        if (mc_Entity.x == 10009) // Snow, Snow Block
                            specR = 18.037, mat = 3.0;
                        else if (mc_Entity.x == 10010) // Gravel
                            specR = 32.06;
                        else if (mc_Entity.x == 10012) // Cobblestone+, Clay
                            specR = 18.037;
                    } else {
                        if (mc_Entity.x == 10050) // Red Sand
                            specR = 80.115, mat = 3.0;
                        else if (mc_Entity.x == 10051) // Andesite, Diorite, Granite, Basalt+, Calcite, Tuff, Dripstone+
                            specR = 12.05;
                        else if (mc_Entity.x == 10052) // Terracottas
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.275,
                            #endif
                            specR = 2.045, mat = 15000.0, color.rgb = vec3(0.03, 1.0, 0.0);
                    }
                }
            } else {
                if (mc_Entity.x < 10106.5) {
                    if (mc_Entity.x < 10102.5) {
                        if (mc_Entity.x == 10053) // Packed Ice, Blue Ice, Purpur Block+, Beehive
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.4,
                            #endif
                            specR = 20.055;
                        else if (mc_Entity.x == 10101) // Birch Log+
                            specR = 3.055;
                        else if (mc_Entity.x == 10102) // Oak Log+
                            specR = 8.055;
                    } else {
                        if (mc_Entity.x == 10103) // Jungle Log+, Acacia Log+
                            specR = 6.055;
                        else if (mc_Entity.x == 10105) // Spruce Log+, Scaffolding, Cartography Table, Bee Nest
                            specR = 6.06;
                        else if (mc_Entity.x == 10106) // Warped Log+
                            specR = 10.07, mat = 102.0,
                            mipmapDisabling = 1.0;
                    }
                } else {
                    if (mc_Entity.x < 10111.5) {
                        if (mc_Entity.x == 10107) // Crimson Log+
                            specR = 10.07, mat = 103.0,
                            mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 10108) // Dark Oak Log+
                            specR = 2.04;		
                        else if (mc_Entity.x == 10111) // Birch Planks+, Fletching Table, Loom
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.77,
                            #endif
                            specR = 20.036;
                    } else {
                        if (mc_Entity.x == 10112) // Oak Planks+, Jungle Planks+, Bookshelf, Composter
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.77,
                            #endif
                            specR = 20.055;
                        else if (mc_Entity.x == 10114) // Acacia Planks+, Barrel
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.7,
                            #endif
                            specR = 20.075;
                        else if (mc_Entity.x == 10115) // Spruce Planks+, Smithing Table
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.7,
                            #endif
                            specR = 20.12;
                    }
                }
            }
        } else {
            if (mc_Entity.x < 10207.5) {
                if (mc_Entity.x < 10201.5) {
                    if (mc_Entity.x < 10118.5) {
                        if (mc_Entity.x == 10116) // Warped Planks+
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.3,
                            #endif
                            specR = 12.075;
                        else if (mc_Entity.x == 10117) // Crimson Planks+, Note Block, Jukebox
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.3,
                            #endif
                            specR = 12.095;
                        else if (mc_Entity.x == 10118) // Dark Oak Planks+
                            specR = 20.4;
                    } else {
                        if (mc_Entity.x == 10198) // Stone Bricks++, Dried Kelp Block
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.7,
                            #endif
                            specR = 20.09;
                        else if (mc_Entity.x == 10199) // Nether Ores, Blackstone++
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            #ifdef EMISSIVE_NETHER_ORES
                                specB = -10.0,
                            #endif
                            specR = 12.087, mat = 20000.0, color.rgb = vec3(1.0, 0.7, 1.0);
                        else if (mc_Entity.x == 10200) // Netherrack, Crimson/Warped Nylium, Block of Amethyst+
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            specR = 12.087, mat = 20000.0, color.rgb = vec3(1.0, 0.7, 1.0);
                        else if (mc_Entity.x == 10201) // Polished Andesite, Polished Diorite, Polished Granite, Melon
                            specR = 6.085;
                    }
                } else {
                    if (mc_Entity.x < 10205.5) {
                        if (mc_Entity.x == 10202) // Nether Bricks+
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            specR = 12.375, mat = 20000.0, color.rgb = vec3(0.55, 1.0, 1.0);
                        else if (mc_Entity.x == 10203 || mc_Entity.x == 10204) // Iron Block+
                            specR = 6.07, specG = 131.0;
                        else if (mc_Entity.x == 10205) // Gold Block+
                            specR = 8.1, mat = 30000.0, color.rgb = vec3(1.0, 1.0, 1.0), specG = 1.0;
                    } else {
                        if (mc_Entity.x == 10206) // Diamond Block
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.65,
                            #endif
                            specR = 100.007, mat = 201.0;
                        else if (mc_Entity.x == 10207) // Emerald Block
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.65,
                            #endif
                            specR = 7.2, mat = 201.0;
                    }
                }
            } else {
                if (mc_Entity.x < 10212.5) {
                    if (mc_Entity.x < 10209.5) {
                        if (mc_Entity.x == 10208) // Netherite Block
                            specR = 12.135, specG = 0.7;
                        else if (mc_Entity.x == 10209) // Ancient Debris
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.0,
                            #endif
                            #ifdef GLOWING_DEBRIS
                                specB = 6.0 + min(0.3 * ORE_EMISSION, 0.9), color.a = 1.0,
                            #endif
                            specR = 8.07, specG = 0.7;
                    } else {
                        if (mc_Entity.x == 10210) // Block of Redstone
                            #ifdef GLOWING_REDSTONE_BLOCK
                                specB = 7.99, mat = 20000.0, color.rgb = vec3(1.1), color.a = 1.0,
                            #endif
                            specR = 8.05, specG = 1.0;
                        else if (mc_Entity.x == 10211) // Lapis Lazuli Block
                            #ifdef GLOWING_LAPIS_BLOCK
                                specB = 6.99, mat = 20000.0, color.rgb = vec3(1.13), color.a = 1.0,
                            #endif
                            specR = 16.11;
                        else if (mc_Entity.x == 10212) // Carpets, Wools
                            specR = 2.02, mat = 15000.0, color.rgb = vec3(0.03, 1.0, 0.0), specG = 0.003, lmCoord.x *= 0.96;
                    }
                } else {
                    if (mc_Entity.x < 10215.5) {
                        if (mc_Entity.x == 10213) // Obsidian
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.0,
                            #endif
                            specR = 2.15, specG = 0.6, mat = 109.0;
                        else if (mc_Entity.x == 10214) // Enchanting Table
                            specR = 2.15, specG = 0.6, mat = 109.0;
                        else if (mc_Entity.x == 10215) // Chain
                            specR = 0.5, specG = 1.0,
                            lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);
                    } else {
                        if (mc_Entity.x == 10216) // Cauldron, Hopper, Anvils
                            specR = 1.08, specG = 1.0, mat = 111.0,
                            lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);
                        else if (mc_Entity.x == 10217) // Sandstone+
                            specR = 24.029;
                        else if (mc_Entity.x == 10218) // Red Sandstone+
                            specR = 24.085;
                    }
                }
            }
        }
    } else {
        if (mc_Entity.x < 11036.5) {
            if (mc_Entity.x < 10231.5) {
                if (mc_Entity.x < 10225.5) {
                    if (mc_Entity.x < 10221.5) {
                        if (mc_Entity.x == 10219) // Quartz+, Daylight Detector, Honeycomb Block
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.35,
                            #endif
                            specR = 16.082;
                        else if (mc_Entity.x == 10220) // Chorus Plant, Chorus Flower Age 5
                            mat = 112.0, specR = 6.1,
                            mipmapDisabling = 1.0, lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);
                        else if (mc_Entity.x == 10221) // Chorus Flower Age<=4
                            specB = 5.0001, specR = 5.07,
                            mipmapDisabling = 1.0, lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);
                    } else {
                        if (mc_Entity.x == 10222) // End Stone++, Smooth Stone+, Lodestone, TNT, Pumpkin+, Mushroom Blocks, Deepslate++
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.5,
                            #endif
                            specR = 12.065;
                        else if (mc_Entity.x == 10223) // Bone Block
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.35,
                            #endif
                            specR = 8.055;
                        else if (mc_Entity.x == 10224) // Concretes
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.2,
                            #endif
                            specR = 3.044, mat = 15000.0, color.rgb = vec3(0.03, 1.0, 0.0);
                        else if (mc_Entity.x == 10225) // Concrete Powders
                            specR = 6.014, mat = 15000.0, color.rgb = vec3(0.01, 1.0, 0.0);
                    }
                } else {
                    if (mc_Entity.x < 10228.5) {
                        if (mc_Entity.x == 10226) // Bedrock
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.0,
                            #endif
                            specR = 16.0675;
                        else if (mc_Entity.x == 10227) // Hay Block, Target
                            specR = 16.085, specG = 0.003, mat = 20000.0, color.rgb = vec3(1.0, 0.0, 0.0);
                        else if (mc_Entity.x == 10228) // Bricks+, Furnaces Unlit, Dispenser, Dropper
                            specR = 10.07;
                    } else {
                        if (mc_Entity.x == 10229) // Farmland Wet
                            mat = 114.0;
                        else if (mc_Entity.x == 10230) // Crafting Table
                            specR = 24.06;
                        else if (mc_Entity.x == 10231) // Cave Vines With Glow Berries
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            specB = 8.3, mat = 20000.0, color.rgb = vec3(1.2, -5.0, 0.0),
                            mipmapDisabling = 1.0, lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);
                    }
                }
            } else {
                if (mc_Entity.x < 11012.5) {
                    if (mc_Entity.x < 10234.5) {
                        if (mc_Entity.x == 10232) // Prismarine+
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.3,
                            #endif
                            specR = 3.08, specG = 0.75;
                        else if (mc_Entity.x == 10233) // Dark Prismarine+
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            specR = 3.11, specG = 0.75;
                        else if (mc_Entity.x == 10234) // Glazed Terracottas
                            specR = 0.5;
                    } else {
                        if (mc_Entity.x == 11004) // Glowstone
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.0,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            lmCoord.x = 0.87, specB = 3.08, color.rgb = vec3(0.69, 0.65, 0.6),
                            mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11008) // Sea Lantern
                            #ifdef COLORED_LIGHT
                                lightVarying = 4.0,
                            #endif
                            specR = 3.1, specG = 0.75,
                            lmCoord.x = 0.87, specB = 16.04,
                            mat = 17000.0, color.rgb = vec3(1.5, 0.67, 2.9),
                            quarterNdotUfactor = 0.0, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11012) // Magma Block
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.0,
                            #endif
                            lmCoord = vec2(0.0), specB = 2.05, color.rgb = vec3(0.85, 0.84, 0.7),
                            quarterNdotUfactor = 0.0, mipmapDisabling = 1.0;
                    }
                } else {
                    if (mc_Entity.x < 11024.5) {
                        if (mc_Entity.x == 11016) // Shroomlight
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.5,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 1.0,
                            #endif
                            lmCoord.x = 0.81, specB = 16.005,
                            mat = 17000.0, color.rgb = vec3(1.5, 0.8, 1.0),
                            quarterNdotUfactor = 0.0;
                        else if (mc_Entity.x == 11020) // Redstone Lamp Lit
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            lmCoord.x = 0.915, specB = 5.099, color.rgb = vec3(0.6), quarterNdotUfactor = 0.0,
                            specG = 0.63, specR = 0.55, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11024) // Redstone Lamp Unlit
                            specG = 0.63, specR = 3.15,	mipmapDisabling = 1.0;
                    } else {
                        if (mc_Entity.x == 11028) // Jack o'Lantern
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.5,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            mat = 17000.0, color.rgb = vec3(1.54, 1.0, 1.15),
                            specR = 12.065, lmCoord.x = 0.87, specB = 16.0001, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11032) // Beacon
                            #ifdef COLORED_LIGHT
                                lightVarying = 4.0,
                            #endif
                            mat = 115.0, lmCoord.x = 0.87;
                        else if (mc_Entity.x == 11036) // End Rod
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 0.0,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 4.0,
                            #endif
                            specR = 1.0, lmCoord.x = 0.88, mat = 116.0;
                    }
                }
            }
        } else {
            if (mc_Entity.x < 11084.5) {
                if (mc_Entity.x < 11060.5) {
                    if (mc_Entity.x < 11048.5) {
                        if (mc_Entity.x == 11040) // Dragon Egg, Spawner
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            mat = 106.0;
                        else if (mc_Entity.x == 11044) // Redstone Wire
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            specB = smoothstep(0.0, 1.0, pow2(length(color.rgb))) * 0.07;
                        else if (mc_Entity.x == 11048) // Redstone Torch
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 2.0,
                            #endif
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            mat = 101.0, lmCoord.x = min(lmCoord.x, 0.86), mipmapDisabling = 1.0;
                    } else {
                        if (mc_Entity.x == 11052) // Redstone Repeater & Comparator Powered
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            mat = 101.0, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11056) // Redstone Repeater & Comparator Unpowered
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            mat = 101.0, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11060) // Observer
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            specR = 10.07, mat = 101.0, specB = 1000.0;
                    }
                } else {
                    if (mc_Entity.x < 11072.5) {
                        if (mc_Entity.x == 11064) // Command Blocks
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 2.5,
                            #endif
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            mat = 104.0, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11068) // Lantern
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            lmCoord.x = 0.87, specB = 3.4, mat = 20000.0, color.rgb = vec3(1.0, 0.0, 0.0),
                            specR = 0.5, specG = 1.0;
                        else if (mc_Entity.x == 11072) // Soul Lantern
                            #ifdef COLORED_LIGHT
                                lightVarying = 2.0,
                            #endif
                            lmCoord.x = min(lmCoord.x, 0.87), specB = 4.15, mat = 20000.0, color.rgb = vec3(0.0, 1.0, 0.0),
                            specR = 0.5, specG = 1.0;
                    } else {
                        if (mc_Entity.x == 11076) // Crimson Fungus, Warped Fungus
                            specB = 16.007, mat = 20000.0, color.rgb = vec3(1.0, 0.0, 0.0);
                        else if (mc_Entity.x == 11078) { // Glow Lichen
                            #if EMISSIVE_LICHEN > 0
                                #if EMISSIVE_LICHEN == 1
                                    float lightFactor = max(1.0 - lmCoord.y, 0.0) * (max(0.533 - max(lmCoord.x - 0.467, 0.0), 0.0) / 0.533);
                                          lightFactor *= lightFactor;
                                          lightFactor *= lightFactor;
                                          lightFactor *= lightFactor;
                                          lightFactor *= lightFactor;
                                #else
                                    float lightFactor = 1.0;
                                #endif
                                specB = 20.0002 + 0.7 * lightFactor;
                                mat = 17000, color.rgb = vec3(1.11, 0.8, 1.0 + lightFactor * 0.07);
                            #endif
                            lmCoord.x = clamp(lmCoord.x, 0.0, 0.9);
                        }
                        else if (mc_Entity.x == 11080) // Furnaces Lit
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            specR = 10.07, mat = 107.0, lmCoord.x = pow(lmCoord.x, 1.5);
                        else if (mc_Entity.x == 11084) // Torch
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 1.0,
                            #endif
                            lmCoord.x = min(lmCoord.x, 0.86), mat = 108.0, mipmapDisabling = 1.0;
                    }
                }
            } else {
                if (mc_Entity.x < 11112.5) {
                    if (mc_Entity.x < 11100.5) {
                        if (mc_Entity.x == 11088) // Soul Torch
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 2.0,
                            #endif
                            lmCoord.x = min(lmCoord.x, 0.86), mat = 108.0, mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11092) // Crying Obsidian, Respawn Anchor
                            #ifdef NOISY_TEXTURES
                                noiseVarying = 1.5,
                            #endif
                            #ifdef COLORED_LIGHT
                                lightVarying = 2.0,
                            #endif
                            specR = 2.15, specG = 0.6, mat = 109.0,
                            specB = 0.75, lmCoord.x = min(lmCoord.x, 0.88), mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11096) // Campfire, Powered Lever
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            lmCoord.x = min(lmCoord.x, 0.885), mat = 110.0;
                        else if (mc_Entity.x == 11100) // Soul Campfire
                            #ifdef COLORED_LIGHT
                                lightVarying = 2.0,
                            #endif
                            lmCoord.x = min(lmCoord.x, 0.885), mat = 110.0;
                    } else {
                        if (mc_Entity.x == 11104) // Jigsaw Block, Structure Block
                            #ifdef SNOW_MODE
                                noSnow = 1.0,
                            #endif
                            specB = 8.004, quarterNdotUfactor = 0.0;
                        else if (mc_Entity.x == 11108) // Sea Pickle
                            #ifdef COLORED_LIGHT
                                lightVarying = 5.0,
                            #endif
                            specB = 12.0003, lmCoord.x = min(lmCoord.x, 0.885), mipmapDisabling = 1.0;
                        else if (mc_Entity.x == 11110) // Sculk Sensor Inactive
                            specB = 0.01, lmCoord = vec2(0.0);
                        else if (mc_Entity.x == 11111) // Sculk Sensor Active
                            specB = 0.05, lmCoord = vec2(0.0);
                        else if (mc_Entity.x == 11112) // Lit Candles
                            #ifdef COLORED_LIGHT
                                lightVarying = 3.0,
                            #endif
                            lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);
                    }
                } else {
                    if (mc_Entity.x < 11129.5) {
                        if (mc_Entity.x < 11121.5) {
                            if (mc_Entity.x == 11116) // Diamond Ore, Emerald Ore
                                #ifdef EMISSIVE_ORES
                                    specB = 0.30, mat = 113.0, mipmapDisabling = 1.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.77,
                                #endif
                                specR = 20.04;
                            else if (mc_Entity.x == 11117) // Deepslate Diamond Ore, Deepslate Emerald Ore
                                #ifdef EMISSIVE_ORES
                                    specB = 0.30, mat = 113.0, mipmapDisabling = 1.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.5,
                                #endif
                                specR = 12.065;
                            else if (mc_Entity.x == 11120) // Gold Ore, Lapis Ore
                                #ifdef EMISSIVE_ORES
                                    specB = 0.08, mat = 113.0, mipmapDisabling = 1.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.77,
                                #endif
                                specR = 20.04;
                            else if (mc_Entity.x == 11121) // Deepslate Gold Ore, Deepslate Lapis Ore
                                #ifdef EMISSIVE_ORES
                                    specB = 0.08, mat = 113.0, mipmapDisabling = 1.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.5,
                                #endif
                                specR = 12.065;
                        } else {
                            if (mc_Entity.x == 11124) // Redstone Ore Unlit
                                #ifdef EMISSIVE_ORES
                                    specB = 4.27, mat = 113.0, mipmapDisabling = 1.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.77,
                                #endif
                                specR = 20.04;
                            else if (mc_Entity.x == 11125) // Deepslate Redstone Ore Unlit
                                #ifdef EMISSIVE_ORES
                                    specB = 4.27, mat = 113.0, mipmapDisabling = 1.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.5,
                                #endif
                                specR = 12.065;
                            else if (mc_Entity.x == 11128) // Redstone Ore Lit
                                #ifdef COLORED_LIGHT
                                    lightVarying = 2.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.77,
                                #endif
                                lmCoord.x *= 0.95,
                                specB = 4.27, mat = 113.0, mipmapDisabling = 1.0,
                                specR = 20.04;
                            else if (mc_Entity.x == 11129) // Deepslate Redstone Ore Lit
                                #ifdef COLORED_LIGHT
                                    lightVarying = 2.0,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.5,
                                #endif
                                lmCoord.x *= 0.95,
                                specB = 4.27, mat = 113.0, mipmapDisabling = 1.0,
                                specR = 12.065;
                        }
                    } else {
                        if (mc_Entity.x < 11135.5) {
                            if (mc_Entity.x == 11132) // Iron Ore
                                #ifdef EMISSIVE_ORES
                                #ifdef EMISSIVE_IRON_ORE
                                    specB = 0.05, mat = 113.0, mipmapDisabling = 1.0, specG = 0.07,
                                #endif
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.77,
                                #endif
                                specR = 20.04;
                            else if (mc_Entity.x == 11133) // Deepslate Iron Ore
                                #ifdef EMISSIVE_ORES
                                #ifdef EMISSIVE_IRON_ORE
                                    specB = 0.05, mat = 113.0, mipmapDisabling = 1.0, specG = 0.07,
                                #endif
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.5,
                                #endif
                                specR = 20.04;
                        } else {
                            if (mc_Entity.x == 11136) // Copper Ore
                                #ifdef EMISSIVE_ORES
                                    specB = 0.20, mat = 113.0, mipmapDisabling = 1.0, specG = 0.1,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.77,
                                #endif
                                specR = 20.04;
                            else if (mc_Entity.x == 11137) // Deepslate Copper Ore
                                #ifdef EMISSIVE_ORES
                                    specB = 0.20, mat = 113.0, mipmapDisabling = 1.0, specG = 0.1,
                                #endif
                                #ifdef NOISY_TEXTURES
                                    noiseVarying = 0.5,
                                #endif
                                specR = 20.04;
                            else if (mc_Entity.x == 11200) // Rails
                                mat = 117.0, lmCoord.x = clamp(lmCoord.x, 0.0, 0.87), mipmapDisabling = 1.0;
                        }
                    }
                }
            }
        }
    }

    // Too bright near a light source fix
    if (mc_Entity.x == 99 || mc_Entity.x == 10204)
        lmCoord.x = clamp(lmCoord.x, 0.0, 0.87);

    // Mipmap Fix
    /*if (mc_Entity.x == 98465498894)
        mipmapDisabling = 1.0; */
#endif

#if !defined COMPBR && defined COLORED_LIGHT
    if (mc_Entity.x < 11048.5) {
        if (mc_Entity.x < 11020.5) {
            if (mc_Entity.x == 10231) // Cave Vines With Glow Berries
                lightVarying = 3.0;
            else if (mc_Entity.x == 11004) // Glowstone
                lightVarying = 3.0;
            else if (mc_Entity.x == 11008) // Sea Lantern
                lightVarying = 4.0;
            else if (mc_Entity.x == 11016) // Shroomlight
                lightVarying = 1.0;
            else if (mc_Entity.x == 11020) // Redstone Lamp Lit
                lightVarying = 3.0;
        } else {
            if (mc_Entity.x == 11028) // Jack o'Lantern
                lightVarying = 3.0;
            else if (mc_Entity.x == 11032) // Beacon
                lightVarying = 4.0;
            else if (mc_Entity.x == 11036) // End Rod
                lightVarying = 4.0;
            else if (mc_Entity.x == 11048) // Redstone Torch
                lightVarying = 2.0;
        }
    } else {
        if (mc_Entity.x < 11088.5) {
            if (mc_Entity.x == 11068) // Lantern
                lightVarying = 3.0;
            else if (mc_Entity.x == 11072) // Soul Lantern
                lightVarying = 2.0;
            else if (mc_Entity.x == 11080) // Furnaces Lit
                lightVarying = 3.0;
            else if (mc_Entity.x == 11084) // Torch
                lightVarying = 1.0;
            else if (mc_Entity.x == 11088) // Soul Torch
                lightVarying = 2.0;
        } else {
            if (mc_Entity.x == 11092) // Crying Obsidian, Respawn Anchor
                lightVarying = 2.0;
            else if (mc_Entity.x == 11096) // Campfire
                lightVarying = 3.0;
            else if (mc_Entity.x == 11100) // Soul Campfire
                lightVarying = 2.0;
            else if (mc_Entity.x == 11108) // Sea Pickle
                lightVarying = 5.0;
            else if (mc_Entity.x == 11112) // Lit Candles
                lightVarying = 3.0;
            else if (mc_Entity.x == 11128) // Redstone Ore Lit
                lightVarying = 2.0;
        }
    }
#endif