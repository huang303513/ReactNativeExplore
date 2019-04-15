import React, { Component } from 'react';
import { FlatList, SectionList, View, Text, StyleSheet } from 'react-native';

export default class ListModule extends Component {
    render() {
        return (
            // <View style={styles.container}>
            //     <FlatList
            //         style={styles.list} data={[
            //             { key: 'Devin' },
            //             { key: 'Jackson' },
            //             { key: 'James' },
            //             { key: 'Joel' },
            //             { key: 'John' },
            //             { key: 'Jillian' },
            //             { key: 'Jimmy' },
            //             { key: 'Julie' },
            //         ]}
            //         renderItem={({ item }) => <Text style={styles.item}>{item.key}</Text>}
            //     />
            // </View>
            <View style={styles.container}>
                <SectionList
                    sections={[
                        { title: 'Dfdsaas ', data: ['Devin'] },
                        { title: 'J', data: ['Jackson', 'James', 'Jillian', 'Jimmy', 'Joel', 'John', 'Julie'] },
                    ]}
                    renderItem={({ item }) => <Text style={styles.item}>{item}</Text>}
                    renderSectionHeader={({ section }) => <Text style={styles.sectionHeader}>{section.title}</Text>}
                    keyExtractor={(item, index) => index}
                />
            </View>
        );
    }
}
// let styles = StyleSheet.create({
//     container: {
//         backgroundColor: 'red',
//         flex: 1,
//         paddingTop: 22
//     },
//     list: {
//         backgroundColor: 'green'
//     },
//     item: {
//         padding: 10,
//         fontSize: 18,
//         height: 44,
//     }
// });

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: 22
    },
    sectionHeader: {
        paddingTop: 2,
        paddingLeft: 10,
        paddingRight: 10,
        paddingBottom: 2,
        fontSize: 14,
        fontWeight: 'bold',
        backgroundColor: 'rgba(247,247,247,1.0)',
    },
    item: {
        padding: 10,
        fontSize: 18,
        height: 44,
    },
})