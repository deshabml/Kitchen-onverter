//
//  RecipesCell.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 26.04.2023.
//

import SwiftUI

struct RecipesCell: View {

    @Binding var recipe: Recipe
//    @Binding var search: String


    var body: some View {
        VStack {
            Image("RecipeIcons")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
            Text("\(recipe.name)")
//                .searchable(text: $recipe.name)

        }
        .font(.custom("AvenirNext", size: CGFloat(16)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.yellow.opacity(0.8))
        .cornerRadius(32)
    }
}
//
//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipesCell(recipe: Recipe(name: "Плов", [
//            ProductRecipe(name: "Баранина", amount: "1", measuringSystem: "Кг"),
//            ProductRecipe(name: "Рис", amount: "1", measuringSystem: "Кг"),
//            ProductRecipe(name: "Морковь", amount: "1", measuringSystem: "Кг"),
//            ProductRecipe(name: "Чеснок", amount: "2", measuringSystem: "Головки"),
//            ProductRecipe(name: "Лук репчатый", amount: "2", measuringSystem: "Шт"),
//            ProductRecipe(name: "Перец острый свежий", amount: "2", measuringSystem: "Стручка"),
//            ProductRecipe(name: "Зира или другие пряности", amount: "", measuringSystem: "По вкусу"),
//            ProductRecipe(name: "Соль", amount: "", measuringSystem: "По Вкусу"),
//            ProductRecipe(name: "Масло растительное", amount: "300", measuringSystem: "Мл")],
//               cookingMethod: """
//            Подготавливаем все продукты для плова.
//            Мясо нарезаем кусочками.
//            Лук режем кубиками, морковь - достаточно крупными брусочками.
//            В разогретом казане слегка обжариваем лук на растительном масле.
//            Добавляем мясо, обжариваем почти до готовности.
//            Засыпаем морковь, обжариваем. Солим, добавляем специи.
//            Рис хорошо промываем, засыпаем в казан, перемешиваем и заливаем кипятком, чтобы вода покрывала рис на 2-2,5 см.
//            Воды лучше не долить. Если в процессе готовки окажется, что воды мало, её спокойно можно добавить. А вот если воды будет много, рис гарантированно переварится.
//            Доводим до кипения, не накрывая крышкой. Пробуем на соль и если нужно досаливаем.
//            Как только закипит, добавляем целые головки чеснока, очищенные от верхней шелухи, и стручки острого перца.
//            Уменьшаем огонь до минимума, накрываем крышкой и оставляем плов минут на 20.
//            Через 20 минут проверяйте: если рис еще сырой, а воды уже нет - долейте немного горячей воды и снова накройте крышкой. Готовый рис не должен быть слишком мягким.
//            Выключаем огонь и даем плову постоять минут 15-20.
//            Традиционно к узбекскому плову готовят салат Ачучук (Ачик-Чучук или, иначе, Шакароб). Готовить его элементарно: нарезаем помидоры и лук, добавляем соль и черный перец. Масло в этот салат не добавляется.
//            Фото приготовления рецепта: Плов, который всегда получается - шаг №11
//            Плов готов! Приятного аппетита!
//
//            """))
//    }
//}
