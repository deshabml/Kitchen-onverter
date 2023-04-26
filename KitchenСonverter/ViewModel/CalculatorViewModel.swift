//
//  MainViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 13.04.2023.
//

import Foundation

class CalculatorViewModel: ObservableObject {

    @Published var recordedConverters: [Converter] = []
    @Published var measuringSystems: [MeasuringSystem] = []
    @Published var products: [Product] = []
    @Published var productQuantity: String = ""
    @Published var itog: String = "0,000000"
    @Published var productPicker: Product = Product()
    @Published var measuringSystemPickerFirst: MeasuringSystem = MeasuringSystem()
    @Published var measuringSystemPickerSecond: MeasuringSystem = MeasuringSystem()

    func recalculation() {
        guard let productQuantity = Double(productQuantity) else { return }
        let firstPicker = measuringSystemPickerFirst
        let secondPicker = measuringSystemPickerSecond
        var calculation: Double = 0
        if firstPicker.isWeight && secondPicker.isWeight {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio
            print(secondPicker.ratio / firstPicker.ratio)
            print(calculation)
        } else if !firstPicker.isWeight && !secondPicker.isWeight {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio
        } else if firstPicker.isWeight {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio / productPicker.density
        } else {
            calculation = productQuantity * firstPicker.ratio / secondPicker.ratio * productPicker.density
        }
        itog = String(format: "%.6f", calculation)
    }

}

extension CalculatorViewModel {

    func getAllData() {
        recordedConverters = RealmService.shared.getConverter()
        measuringSystems = RealmService.shared.getMeasuringSystem()
        products = RealmService.shared.getProduct()
    }

    func getStartPickerData() {
        productPicker = RealmService.shared.getProduct()[0]
        measuringSystemPickerFirst = RealmService.shared.getMeasuringSystem()[0]
        measuringSystemPickerSecond = RealmService.shared.getMeasuringSystem()[0]
    }

    func savingConverter() {
        RealmService.shared.createObject(object: Converter(product: productPicker, itog: itog, measuringSystem: measuringSystemPickerSecond))
        getAllData()
    }

    func savingObject<T>(object: T) {
        RealmService.shared.createObject(object: object)
        getAllData()
    }

    func updateObject<T>(oldObject: T, newObject: T) {
        RealmService.shared.updateObject(oldObject: oldObject, newObject: newObject)
        getAllData()
    }

    func deleteObject<T>(object: T) {
        RealmService.shared.deleteObject(object: object)
        getAllData()
    }

    func initialFillingDataBase() {
        let firstLaunch = RealmService.shared.getFirstLaunch()
        guard firstLaunch.isEmpty else { return }
        RealmService.shared.createObject(object: FirstLaunch())
        let startMeasuringSystems: [MeasuringSystem] = [MeasuringSystem(name: "Г", isWeight: true, ratio: 1),
                                                       MeasuringSystem(name: "Кг", isWeight: true, ratio: 1000),
                                                       MeasuringSystem(name: "Л", isWeight: false, ratio: 1000),
                                                       MeasuringSystem(name: "Мл", isWeight: false, ratio: 1),
                                                       MeasuringSystem(name: "Унция", isWeight: true, ratio: 31.1034768),
                                                       MeasuringSystem(name: "Фут", isWeight: true, ratio: 453.59237),
                                                       MeasuringSystem(name: "Стакан", isWeight: false, ratio: 200)]
        startMeasuringSystems.forEach { measuringSystems in
            RealmService.shared.createObject(object: measuringSystems)
        }
        let startProducts: [Product] = [Product(name: "Вода", density: 1),
                                              Product(name: "Гречка", density: 0.85),
                                              Product(name: "Рис", density: 0.9),
                                              Product(name: "Cоль", density: 0.9),
                                              Product(name: "Сахар", density: 1.587),
                                              Product(name: "Мука", density: 0.68)]
        startProducts.forEach { product in
            RealmService.shared.createObject(object: product)
        }
        let startTypeMeasuringSystem: [TypeMeasuringSystem] = [TypeMeasuringSystem(name: "Вес", isWeight: true),
                                                          TypeMeasuringSystem(name: "Объём", isWeight: false)]
        startTypeMeasuringSystem.forEach { typeMeasuringSystem in
            RealmService.shared.createObject(object: typeMeasuringSystem)
        }
        let recepes: [Recipe] = [
            Recipe(name: "Борщ с говядиной", [
                ProductRecipe(name: "Говядина", amount: "500", measuringSystem: "Г"),
                ProductRecipe(name: "Свёкла", amount: "250", measuringSystem: "Г"),
                ProductRecipe(name: "Картофель", amount: "200", measuringSystem: "Г"),
                ProductRecipe(name: "Капуста", amount: "300", measuringSystem: "Г"),
                ProductRecipe(name: "Морковь", amount: "100", measuringSystem: "Г"),
                ProductRecipe(name: "Лук репчатый", amount: "100", measuringSystem: "Г"),
                ProductRecipe(name: "Томатная паста", amount: "100", measuringSystem: "Г")],
                   cookingMethod: """
                   1. Первым делом нужно сварить бульон. Для этого говядину на кости промыть под проточной водой, положить ее в кастрюлю и залить холодной водой. Можно добавить 1 чайную ложку соли (но, мясо разварится быстрее,в несоленой воде). Довести до кипения и убавить огонь до минимума. Борщ нужно готовить на медленном огне, тогда овощи в нем не разварятся и не превратятся в кашу!
                   2. Чтобы бульон был прозрачным, периодически снимайте грязную пенку и готовьте на медленном огне. Говядина варится около 1,5-2 часа. Готовность мяса можно проверить по тому, насколько легко оно отделяется от кости.
                   3. Пока готовится бульон, нужно почистить овощи: картофель, морковь, свеклу, лук. Со свежей капусты удалить испорченные листочки и нашинковать.
                   4. Когда мясо приготовится, его нужно вынуть из бульона и немного остудить. Затем отделить мясо от кости и разделать на небольшие кусочки. Это удобно делать при помощи двух вилок.
                   5. Разделанное вареное мясо опустить обратно в бульон. Не забывайте регулярно продолжать снимать грязную пенку с поверхности, чтобы классический борщ получился без грязных хлопьев вареного мясного белка.
                   6. Когда бульон закипит, отправляем в очищенный, нарезанный кубиками картофель.
                   7. Капусту отправить в кастрюлю следом за капустой, после того как вода вновь закипит. Каждый новый ингредиент желательно закладывать каждый раз, как закипит бульон (не забывайте, что борщ готовится на медленном огне). Добавляем соль и перец. По желанию можно сдобрить борщ специями: хмели-сунели, карри, аджика (сушеная).
                   """, dish: Dish.first.description),
            Recipe(name: "Картошка толченка", [
                ProductRecipe(name: "Картошка", amount: "1", measuringSystem: "Кг"),
                ProductRecipe(name: "Молоко", amount: "300", measuringSystem: "Mл"),
                ProductRecipe(name: "Сливочное масло", amount: "3", measuringSystem: "Столовые Ложки"),
                ProductRecipe(name: "Соль", amount: "20", measuringSystem: "Г")],
                   cookingMethod: """
                Шаг 1. Как сделать картошку толченку? Подготовьте необходимые продукты. Картофель хорошо промойте в проточной воде и очистите от земли и всех загрязнений.
                Шаг 2. С помощью овощечистки очистите помытый картофель от кожуры и ополосните водой. Крупные клубни разрежьте на 2-3 части. Сложите очищенный картофель в кастрюлю подходящего размера и налейте в неё воды, чтобы она покрывала весь картофель. Поставьте кастрюлю на огонь и доведите до кипения. Отварите картофель в кипящей воде до мягкости. На это уйдет минут 20. Добавьте соль по вкусу. Для аромата можно добавить в воду лавровый лист или пару зубчиков чеснока.
                Шаг 3. Готовность картофеля можно проверить, просто проткнув его ножом или вилкой. Готовый картофель будет легко прокалываться или даже развалится на части. С вареного картофеля слейте горячую воду и добавьте к нему сливочное масло.
                Шаг 4. С помощью толкушки помните картофель в пюре. На горячем картофеле сливочное масло сразу будет таять и пропитывать его своим вкусом и ароматом.
                Шаг 5. Затем влейте в размятый картофель теплое молоко и еще раз хорошо помните его, чтобы молоко полностью разошлось и впиталось в картофель. Для получения более диетического варианта картофельного гарнира его можно разминать без молока и сливок. Просто оставьте немного воды, в которой он варился, и добавляйте её понемногу в размятую картошку. Но чем выше жирность добавляемого молока или сливок, тем пышнее будет получаться готовое пюре.
                Шаг 6. Регулируя количество добавляемого молока можно регулировать консистенцию готового пюре. В готовый гарнир можно вмешать немного обжаренного, мелко нарезанного лука или моркови, а также измельченные грибы, тертый сыр или зелень. Каждый раз будет новый вкус такого привычного всем гарнира. Приятного аппетита!

                """, dish: Dish.Second.description),
            Recipe(name: "Плов", [
                ProductRecipe(name: "Баранина", amount: "1", measuringSystem: "Кг"),
                ProductRecipe(name: "Рис", amount: "1", measuringSystem: "Кг"),
                ProductRecipe(name: "Морковь", amount: "1", measuringSystem: "Кг"),
                ProductRecipe(name: "Чеснок", amount: "2", measuringSystem: "Головки"),
                ProductRecipe(name: "Лук репчатый", amount: "2", measuringSystem: "Шт"),
                ProductRecipe(name: "Перец острый свежий", amount: "2", measuringSystem: "Стручка"),
                ProductRecipe(name: "Зира или другие пряности", amount: "", measuringSystem: "По вкусу"),
                ProductRecipe(name: "Соль", amount: "", measuringSystem: "По Вкусу"),
                ProductRecipe(name: "Масло растительное", amount: "300", measuringSystem: "Мл")],
                   cookingMethod: """
                Подготавливаем все продукты для плова.
                Мясо нарезаем кусочками.
                Лук режем кубиками, морковь - достаточно крупными брусочками.
                В разогретом казане слегка обжариваем лук на растительном масле.
                Добавляем мясо, обжариваем почти до готовности.
                Засыпаем морковь, обжариваем. Солим, добавляем специи.
                Рис хорошо промываем, засыпаем в казан, перемешиваем и заливаем кипятком, чтобы вода покрывала рис на 2-2,5 см.
                Воды лучше не долить. Если в процессе готовки окажется, что воды мало, её спокойно можно добавить. А вот если воды будет много, рис гарантированно переварится.
                Доводим до кипения, не накрывая крышкой. Пробуем на соль и если нужно досаливаем.
                Как только закипит, добавляем целые головки чеснока, очищенные от верхней шелухи, и стручки острого перца.
                Уменьшаем огонь до минимума, накрываем крышкой и оставляем плов минут на 20.
                Через 20 минут проверяйте: если рис еще сырой, а воды уже нет - долейте немного горячей воды и снова накройте крышкой. Готовый рис не должен быть слишком мягким.
                Выключаем огонь и даем плову постоять минут 15-20.
                Традиционно к узбекскому плову готовят салат Ачучук (Ачик-Чучук или, иначе, Шакароб). Готовить его элементарно: нарезаем помидоры и лук, добавляем соль и черный перец. Масло в этот салат не добавляется.
                Фото приготовления рецепта: Плов, который всегда получается - шаг №11
                Плов готов! Приятного аппетита!

                """, dish: Dish.Hot.description),
            Recipe(name: "Домашние пельмени", [
                ProductRecipe(name: "Мука пшеничная просеянная", amount: "500", measuringSystem: "Г"),
                ProductRecipe(name: "Вода горячая", amount: "250", measuringSystem: "Мл"),
                ProductRecipe(name: "Яйцо", amount: "1", measuringSystem: "Шт"),
                ProductRecipe(name: "Соль", amount: "1", measuringSystem: "ч. ложка без горки"),
                ProductRecipe(name: "Масло растительное без запаха", amount: "25", measuringSystem: "Мл"),
                ProductRecipe(name: "Мясо", amount: "250", measuringSystem: "Мг"),
                ProductRecipe(name: "Лук репчатый", amount: "200", measuringSystem: "Г"),
                ProductRecipe(name: "Сало", amount: "30", measuringSystem: "Г"),
                ProductRecipe(name: "Вода", amount: "80", measuringSystem: "Г"),
                ProductRecipe(name: "Соль", amount: "80", measuringSystem: "ч. ложка без горки"),
                ProductRecipe(name: "Перец чёрный молотый", amount: "", measuringSystem: "По Вкусу"),
                ProductRecipe(name: "Лист лавровый", amount: "", measuringSystem: "По Вкусу"),
                ProductRecipe(name: "Соль", amount: "", measuringSystem: "По Вкусу"),
                ProductRecipe(name: "Перец чёрный горошком", amount: "80", measuringSystem: "По Вкусу"),
                ProductRecipe(name: "Лук репчатый", amount: "1/4", measuringSystem: "Шт"),
                ProductRecipe(name: "Масло сливочное", amount: "", measuringSystem: "По Вкусу")],
                   cookingMethod: """
                В муку добавляем соль, яйцо и растительное масло. Слегка перемешиваем.
                Сдвигаем яйцо немного к краю миски, чтобы оно не сварилось. Заливаем муку горячей водой (температура 70-75 градусов), постоянно перемешивая ложкой.
                Затем замешиваем тесто руками. Если останутся небольшие вкрапления сварившегося желтка - ничего страшного, они разойдутся при вымешивании теста.
                Вымешиваем тесто примерно 7 минут, пока оно полностью не остынет.
                Тесто не липнет ни к рукам, ни к поверхности, поэтому дополнительно муку можно не добавлять.
                Накрываем тесто полотенцем и даём ему отдохнуть 20-30 минут.
                Готовим начинку. Вес теста - приблизительно 800 г, поэтому и начинки берём тоже 800 г.
                Мясо, сало и лук перемалываем с помощью мясорубки. (Можно взять уже готовый фарш и смешать с измельчённым луком.)
                Фарш солим и перчим. Добавляем немного воды, чтобы фарш был слегка жидковатым. Перемешиваем.
                Фото приготовления рецепта: Домашние пельмени - шаг №6
                Берём часть теста весом 120 г, выкладываем на присыпанную мукой поверхность и раскатываем по размеру пельменницы. Остальное тесто отправляем под полотенце, чтобы оно не засыхало.
                Хорошо посыпаем мукой верх пельменницы и ту сторону теста, которую будем выкладывать на пельменницу, чтобы пельмени хорошо от неё отделялись.
                Фото приготовления рецепта: Домашние пельмени - шаг №8
                Разравниваем тесто по всей поверхности пельменницы.
                Выкладываем фарш в ячейки. Следим, чтобы фарш не попадал на тесто вокруг ячеек, таким образом тесто будет хорошо скрепляться и пельмени не развалятся.
                Раскатываем еще одну часть теста (весом 80 г), накрываем пельменницу, хорошо прокатываем скалкой.
                Убираем остатки теста по краям, кладём под полотенце, их можно использовать повторно. Вытряхиваем пельмени из пельменницы.
                Из этого количества теста и фарша получилось 185 пельменей (5 пельменниц). Пельмени выкладываем на посыпанную мукой поверхность и замораживаем.
                Отвариваем пельмени в подсоленной воде с лавровым листом, горошинами чёрного перца и луком. Слегка перемешиваем пельмени и варим 2-3 минуты после того, как они всплывут. Даже если варить дольше, пельмени не разварятся.
                Подаём пельмени со сливочным маслом.
                Приятного аппетита!
                """, dish: Dish.first.description)]
        recepes.forEach { recepe in
            RealmService.shared.createObject(object: recepe)
        }
    }
    
}

